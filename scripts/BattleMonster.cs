using Godot;
using System;

public class BattleMonster : Sprite
{
	static readonly PackedScene MONSTER_MENU = (PackedScene) ResourceLoader.Load("res://scripts/monster_panel.tscn");

	private Sprite shield;
	private AudioStreamPlayer cry;
	private Monster resource;

	private int _id = 0;
	public int id 
	{
		get { return this._id; }
		set { 
			this._id = value;
			setMonsterID(_id);
			} 
	}
	
	public int hp = 0;
	public uint atkAdd = 0;
	public uint defAdd = 0;
	public uint spdAdd = 0;

	public bool guarding = false;
	public bool ownedByPlayer = false;
	public bool dead = false;

	private void setMonsterID(int newId)
	{
		if (newId > 8 || newId < 0) newId = 0;
		_id = newId;

		resource = (Monster) ResourceLoader.Load($"res://monster/{_id}.tres");         

		dead = false;
		hp = resource.MaxHP;
		Texture = resource.Sprite;
		Offset = resource.SpriteOffset;

		GD.Print($"{resource.Name} Monster setup did fine");
	}

	public override void _Ready()
	{
		setMonsterID(id);

		hp = ownedByPlayer ? Global.LastMonsterHP : hp;
		shield = GetNode("Shield") as Sprite;
		cry = GetNode("Cry") as AudioStreamPlayer;

		playCry();
	}

	private async void playCry()
	{
		cry.Stream = (AudioStream) ResourceLoader.Load($"res://streams/cries/{_id}.mp3");
		cry.Play();

		await ToSignal(cry, "finished");
		GD.Print($"{_id} cry playback ended");
	}

	public override void _Process(float _delta)
	{
		if (guarding) shield.Visible = !shield.Visible;
		else shield.Visible = false;
	}

	public bool Attack(BattleMonster target)
	{
		if (target.dead) return false;

		Sprite attackAnim = (Sprite) ((PackedScene) ResourceLoader.Load("res://scripts/attack_anim.tscn")).Instance();

		GetParent().AddChild(attackAnim);
		attackAnim.Position = target.Position;

		int hpCalc = target.hp - resource.Atk;

		if (hpCalc <= 0)
		{
			target.hp = 0;
			target.Kill();
			return true;
		}

		target.hp -= resource.Atk;

		return true;
	}
	public async void Kill()
	{
		dead = true;
		await ToSignal(GetTree().CreateTimer(0.5f), "timeout");

		if (ownedByPlayer)
		{
			Global.MonsterAmount[id] -= 1;
			GetTree().CurrentScene.Set("monMenuOpen", true);

			Panel MonsterPanel = (Panel) MONSTER_MENU.Instance();

			GetTree().Root.AddChild(MonsterPanel);
			MonsterPanel.GetNode("Exit").QueueFree();
		}
		else
		{
			Global.MonsterAmount[id] += 1;
			Global.LastMonsterHP = ((BattleMonster) GetTree().CurrentScene.Get("playerMon")).hp;
			GetTree().ReloadCurrentScene();
		}
	}
}

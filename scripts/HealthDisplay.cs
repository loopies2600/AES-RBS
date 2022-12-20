using Godot;
using System;

public class HealthDisplay : Node2D
{
	static readonly AtlasTexture HEART = (AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/heart.tres");
	static readonly AtlasTexture[] NUMTEX = new AtlasTexture[10] 
	{(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/0.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/1.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/2.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/3.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/4.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/5.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/6.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/7.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/8.tres"),
	(AtlasTexture) ResourceLoader.Load("res://monster/health_numbers/9.tres") };

	private BattleMonster tgtMon;

	public override void _Ready()
	{
		Position = tgtMon.Position;
	}

	public override void _Process(float delta)
	{
		base._Process(delta);
		Update();
	}

	public override void _Draw()
	{
		base._Draw();
		
		DrawTexture(HEART, new Vector2(-72, -150));

		string healthString = tgtMon.hp.ToString();

		for (int i = 0; i < healthString.Length; i++)
		{
			int numID = healthString[i] - '0';
			DrawTexture(NUMTEX[numID], new Vector2(64 * i, -150));
		}
	}
}

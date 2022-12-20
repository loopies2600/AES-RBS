using Godot;
using System;

public class Monster : Resource
{
	[Export]
	public string Name = "DUMMY";
	[Export]
	public AtlasTexture Sprite;
	[Export]
	public ushort MaxHP = 1;
	[Export]
	public ushort Atk = 1;
	[Export]
	public ushort Def = 1;
	[Export]
	public ushort Spd = 1;
	[Export]
	public Vector2 SpriteOffset = new Vector2();
}

using Godot;
using System;

public class title : TextureButton
{
	public override void _Pressed()
	{
		base._Pressed();
		GetTree().ChangeScene("res://main.tscn");
	}
}

package nom;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxGroup;
import flixel.FlxPoint;

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
#end
class QuickCalls {
    #if !flash 
    public static function QuickShader(source:String, uniformSets:Array<Array<Dynamic>>):FlxRuntimeShader {
        var shad = new FlxRuntimeShader(source);
        for (arg in uniformSets) {
            if (Std.is(arg[1], Bool)) {
                shad.setBool(arg[0], cast arg[1]);
            } else if (Std.is(arg[1], Int)) {
                shad.setInt(arg[0], cast arg[1]);
            } else if (Std.is(arg[1], Float)) {
                shad.setFloat(arg[0], cast arg[1]);
            } else if (Std.is(arg[1], String)) {
                shad.setString(arg[0], cast arg[1]);
            } else {
                trace("unsupported uniform type at the moment");
            }
        }
        return shad;
    }
    #end
    public static function addQuickSprite(x:Float, y:Float, graphic:Dynamic, parent:FlxGroup, scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = parent.add(new FlxSprite(x, y, graphic)) as FlxSprite;
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        return sprite;
    }
}
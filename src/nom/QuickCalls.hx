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
    public static function addQuickSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scrollFactor:FlxPoint = null, scale:Array<Float>):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y).loadGraphic(graphicPath);//.scale.set());
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if(parent!=null)parent.add(sprite);
        return sprite;
    }
}
package nom;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
#end
class QuickCalls {

    #if !flash

    // EXAMPLE:
    /*

        var shader:FlxRuntimeShader = QuickCalls.quickShader(
            "
                #pragma header
                uniform float lol;

                void main() 
                {
                    gl_FragColor = texture2D(bitmap, openfl_TextureCoordv).brga;
                }
            ",
            [
                ["Float", lol, 0.1]
            ]
        );
    */
    public static function quickShader(source:String, uniformSets:Array<Array<Dynamic>>):FlxRuntimeShader {
        var shad = new FlxRuntimeShader(source);
    
        var type_to_set:Map<String, Dynamic->Void> = [
            'bool' => shad.setBool,
            "int" => shad.setInt,
            "float" => shad.setFloat,
            "string" => shad.setString
        ];

        for (arg in uniformSets) {
            var uniformType:String = arg[0];  // type AS STRING THO!!!
            var uniformName:String = arg[1];
            var uniformValue:Dynamic = arg[2];
    
            var setDaUniform:Dynamic->Void = type_to_set.get(uniformType.toLowerCase(), function(lol) {
                trace("unsupported uniform type at the moment :( \nplease report to the GitHub!!");
            });
    
            setDaUniform(uniformName, cast(uniformValue, Dynamic)); // Cast uniformValue to the correct type
        }
        return shad;
    }    
    #end

    public static function quickSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scale:Array<Float>, scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y, graphicPath).scale.set(scale[0], scale[1]);
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if(parent!=null)parent.add(sprite);
        return sprite;
    }
}
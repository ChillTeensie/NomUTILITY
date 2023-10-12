package nom;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.effects.particles.FlxEmitter;

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
    
            setDaUniform(uniformName, uniformValue); // i dont think i need to cast actually
        }
        return shad;
    }    

    public static function quickPortShader(source:String, uniformSets:Array<Array<Dynamic>>):FlxRuntimeShader {
        var shad = new ShadertoyPorter(source).portShader;
    
        var type_to_set:Map<String, Dynamic->Void> = [
            'bool' => shad.setBool,
            "int" => shad.setInt,
            "float" => shad.setFloat,
            "string" => shad.setString
        ];

        for (arg in uniformSets) {
            var uniformType:String = arg[0]; 
            var uniformName:String = arg[1];
            var uniformValue:Dynamic = arg[2];
    
            var setDaUniform:Dynamic->Void = type_to_set.get(uniformType.toLowerCase(), function(lol) {
                trace("unsupported uniform type at the moment :( \nplease report to the GitHub!!");
            });
    
            setDaUniform(uniformName, uniformValue);
        }
        return shad;
    }    
    #end

    public static function quickText(x:Float, y:Float, text:String, size:Int, ?width:Int = 0, ?extraParams:Array<Dynamic>):FlxText{
        var text:FlxText = new FlxText(x,y,width,text,size);

        if (extraArgs != null)
            for (arg in extraArgs) if (arg.length >= 2)  Reflect.setProperty(text, Std.string(arg[0]), arg[1]);

        return text;
    }

    public static function quickSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scale:Array<Float>, scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y, graphicPath).scale.set(scale[0], scale[1]);
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if(parent!=null)parent.add(sprite);
        return sprite;
    }


    public static function quickAnimatedSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scale:Array<Float>, frames:Array<Int>, frameRate:Float, animName:String = "animation1", scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y, graphicPath).scale.set(scale[0], scale[1]);
        sprite.animation.add(animName, frames, frameRate, true);
        sprite.play(animName);
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if (parent != null) parent.add(sprite);
        return sprite;
    }

    public static function quickParticleEmitter(
            x:Float = 0, 
            y:Float = 0, 
            width:Float = 1280, 
            height:Float = 720, 
            particleClass:Class<T> = null,
            maxParticles:Int = 10, 
            particleLifespan:Float = 3,  
            autoBuffer:Bool = false, 
            frequency:Float = 0.1, 
            ?gravity:FlxPoint, 
            ?blend:BlendMode
            
        ):FlxEmitter

        {
            var emitter:FlxEmitter = new FlxEmitter(x, y, maxParticles);

            emitter.width = width;
            emitter.height = height;
            emitter.particleClass = particleClass;
            emitter.lifespan = particleLifespan;
            emitter.frequency = frequency;

            if (gravity != null) emitter.gravity = gravity;
            if(emitter != null) emitter.blend = blend; 


            emitter.autoBuffer = autoBuffer; 

            return emitter;
    }
}

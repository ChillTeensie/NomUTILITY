package nom;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.effects.particles.FlxEmitter;

#if !flash
import flixel.addons.display.FlxRuntimeShader;
import nom.shaders.ShadertoyPorter;
#end

class QuickCalls {
    #if !flash

    /**
    * Create and configure a custom shader for use in your game.
    *
    * @param source The shader source code.
    * @param uniformSets An array of uniform settings for the shader.
    * @return A configured FlxRuntimeShader instance.
    */
    public static function quickShader(source:String, uniformSets:Array<Dynamic>):FlxRuntimeShader {
        var shad = new FlxRuntimeShader(source);

        var type_to_set = [
            'bool' => shad.setBool,
            'int' => shad.setInt,
            'float' => shad.setFloat,
            'string' => shad.setString
        ];

        for (arg in uniformSets) {
            var uniformType:String = arg[0];
            var uniformName:String = arg[1];
            var uniformValue:Dynamic = arg[2];

            var setDaUniform = type_to_set.get(uniformType.toLowerCase(), function(lol) {
                trace('unsupported uniform type at the moment :(\nplease report to the GitHub!!');
            });

            setDaUniform(uniformName, uniformValue);
        }
        return shad;
    }

    /**
     * Create and configure a shader ported from Shadertoy for use in your game.
     *
     * @param source The shader source code.
     * @param uniformSets An array of uniform settings for the shader.
     * @return A configured FlxRuntimeShader instance.
     */
    public static function quickPortShader(source:String, uniformSets:Array<Dynamic>):FlxRuntimeShader {
        var shad = new ShadertoyPorter(source).portShader;

        var type_to_set = [
            'bool' => shad.setBool,
            'int' => shad.setInt,
            'float' => shad.setFloat,
            'string' => shad.setString
        ];

        for (arg in uniformSets) {
            var uniformType:String = arg[0];
            var uniformName:String = arg[1];
            var uniformValue:Dynamic = arg[2];

            var setDaUniform = type_to_set.get(uniformType.toLowerCase(), function(lol) {
                trace('unsupported uniform type at the moment :(\nplease report to the GitHub!!');
            });

            setDaUniform(uniformName, uniformValue);
        }
        return shad;
    }
    #end

    /**
     * Create a FlxText object with optional additional parameters.
     *
     * @param x The x-coordinate of the text.
     * @param y The y-coordinate of the text.
     * @param text The text content.
     * @param size The font size.
     * @param width Optional width of the text.
     * @param extraParams An array of additional parameters for the FlxText.
     * @return A configured FlxText instance.
     */
    public static function quickText(x:Float, y:Float, text:String, size:Int, ?width:Int = 0, ?extraParams:Array<Dynamic>):FlxText {
        var flxText:FlxText = new FlxText(x, y, width, text, size);

        if (extraParams != null) {
            for (arg in extraParams) {
                if (arg.length >= 2) {
                    Reflect.setProperty(flxText, Std.string(arg[0]), arg[1]);
                }
            }
        }

        return flxText;
    }

    /**
     * Create and configure a FlxSprite object with additional options.
     *
     * @param x The x-coordinate of the sprite.
     * @param y The y-coordinate of the sprite.
     * @param graphicPath The path to the sprite's graphic.
     * @param parent The parent FlxGroup to add the sprite to.
     * @param scale An array of x and y scale values.
     * @param scrollFactor Optional scroll factor for the sprite.
     * @return A configured FlxSprite instance.
     */
    public static function quickSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scale:Array<Float>, ?scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y, graphicPath).scale.set(scale[0], scale[1]);
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if (parent != null) parent.add(sprite);
        return sprite;
    }

    /**
     * Create and configure an animated FlxSprite object.
     *
     * @param x The x-coordinate of the sprite.
     * @param y The y-coordinate of the sprite.
     * @param graphicPath The path to the sprite's graphic.
     * @param parent The parent FlxGroup to add the sprite to.
     * @param scale An array of x and y scale values.
     * @param frames An array of frame indices for the animation.
     * @param frameRate The animation frame rate.
     * @param animName The name of the animation.
     * @param scrollFactor Optional scroll factor for the sprite.
     * @return A configured animated FlxSprite instance.
     */
    public static function quickAnimatedSprite(x:Float, y:Float, graphicPath:Dynamic, parent:FlxGroup, scale:Array<Float>, frames:Array<Int>, frameRate:Float, ?animName:String = "animation1", ?scrollFactor:FlxPoint = null):FlxSprite {
        var sprite:FlxSprite = new FlxSprite(x, y, graphicPath).scale.set(scale[0], scale[1]);
        sprite.animation.add(animName, frames, frameRate, true);
        sprite.play(animName);
        if (scrollFactor != null) {
            sprite.scrollFactor = scrollFactor;
        }
        if (parent != null) parent.add(sprite);
        return sprite;
    }

    /**
     * Create and configure a particle emitter for particle effects.
     *
     * @param x The x-coordinate of the emitter.
     * @param y The y-coordinate of the emitter.
     * @param width The width of the emitter.
     * @param height The height of the emitter.
     * @param particleClass The class for custom particles (optional).
     * @param maxParticles The maximum number of particles.
     * @param particleLifespan The lifespan of each particle.
     * @param autoBuffer Whether to automatically buffer particles.
     * @param frequency The emission frequency.
     * @param gravity Optional gravity settings.
     * @param blend Optional blend mode.
     * @return A configured FlxEmitter instance for particle effects.
     */
    public static function quickParticleEmitter(
        x:Float = 0,
        y:Float = 0,
        width:Float = 1280,
        height:Float = 720,
        particleClass:Class<Dynamic>,
        maxParticles:Int = 10,
        particleLifespan:Float = 3,
        autoBuffer:Bool = false,
        frequency:Float = 0.1,
        ?gravity:FlxPoint = null,
        ?blend:BlendMode = null
    ):FlxEmitter {
        var emitter:FlxEmitter = new FlxEmitter(x, y, maxParticles);

        emitter.width = width;
        emitter.height = height;
        emitter.particleClass = particleClass;
        emitter.lifespan = particleLifespan;
        emitter.frequency = frequency;

        if (gravity != null) emitter.gravity = gravity;
        if (blend != null) emitter.blend = blend;

        emitter.autoBuffer = autoBuffer;

        return emitter;
    }
}
package nom.funkin;

// if anyone uses this pls credit me on ya project :p

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;

public class NomFunkinUtil {
    /*  - asset (automatically knows which folder via stage name)
        - position 
        - scroll factor
        - scale factor (uses scale.scale instead of set in order to just be a float)
        - blend mode
        - extra arguments (reads string then uses Reflect to set value)
    */
    public static function makeBGSprite
    (
        asset:String, 
        pos:Array<Float>, 
        scroll:Array<Float>, 
        ?scalefac:Float = -1,
        ?infront:Bool, 
        ?blend:BlendMode,
        ?extraArgs:Array<Dynamic>
    ) 
    {
        var i = new FlxSprite()
            .loadGraphic(Paths.image('bgs/' + PlayState.instance.curStage + asset, 'shared'))
            .scrollFactor.set(scroll[0], scroll[1]);

        i.setPosition(pos[0], pos[1]);

        if(scalefac != -1) i.scale.scale(scalefac); // scale.scale is abstract so :v
        if(blend != null) i.blend = blend;
        if (infront == true) PlayState.instance.add(i);
        else PlayState.instance.foregroundSprites.push(i);

        if (extraArgs != null)
            for (arg in extraArgs) if (arg.length >= 2)  Reflect.setProperty(i, Std.string(arg[0]), arg[1]);

        PlayState.instance.bgItems.push(i);
        trace(asset, pos, scroll, scalefac, infront, blend, extraArgs);
    }
}
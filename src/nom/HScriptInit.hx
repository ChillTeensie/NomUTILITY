package nom;

import sys.FileSystem;
import sys.io.File;
import nom.*;

/*
  usage:

    in code:

    var HScript:HScriptInit = new HScriptInit();
    HScript.runScript(path to script (without ".hx") );

    function update(elapsed)
    {
      HScript.executeFunction("update",[elapsed]);
    }

    script:

    function update(elapsed){
        trace(elapsed);
    }

    output:
    elapsed
*/

class HScriptInit{

    var scripts:Array<Dynamic>;

    public function new(){
        scripts = [];
        trace("HScript Initilized. Use runScript to run a script, executeFunction to execute a function.");
    }

    public function runScript(pathToScript:String,?variablesToPass:Array<Array<Dynamic>>){
        if(!FileSystem.exists(pathToScript+".hx")){
            lime.app.Application.current.window.alert("No script found at "+pathToScript+".hx","Hscript Error!");
            return;
        }
        var rizzler = new hscript.Parser().parseString(File.getContent(pathToScript+".hx"));
        var script = new hscript.Interp();

        script.variables.set("FlxG",flixel.FlxG);
        script.variables.set("FlxGame",flixel.FlxGame);
        script.variables.set("FlxState",flixel.FlxState);
        script.variables.set("FlxSprite",flixel.FlxSprite);
        script.variables.set("FlxCamera",flixel.FlxCamera);
        script.variables.set("FlxObject",flixel.FlxObject);
        script.variables.set("FlxBasic",flixel.FlxBasic);
        script.variables.set("QuickCalls",nom.QuickCalls);
        script.variables.set("NomEasyApi",nom.NomEasyApi);
        script.variables.set("FlxTimer",flixel.util.FlxTimer);
        script.variables.set("FlxCollision",flixel.util.FlxCollision);
        script.variables.set("FlxColor",flixel.util.FlxColor);
        script.variables.set("FlxGradient",flixel.util.FlxGradient);
        script.variables.set("FlxSpriteUtil",flixel.util.FlxSpriteUtil);
        script.variables.set("FlxBar",flixel.ui.FlxBar);
        script.variables.set("FlxButton",flixel.ui.FlxButton);
        script.variables.set("FlxSpriteButton",flixel.ui.FlxSpriteButton);
        script.variables.set("FlxTypedButton",flixel.ui.FlxTypedButton);
        if(variablesToPass != null){
            for (variableTable in variablesToPass){
                script.variables.set(variableTable[0],variableTable[1]);
            }
        }

        script.execute(rizzler);
        scripts.push(script);
        trace(scripts);
    }

    public function executeFunction(functionName:String,args:Array<Dynamic>){
        for (script in scripts){
            if(script.variables.exists(functionName))
            {
                var functionToRun = script.variables.get(functionName);
                Reflect.callMethod(script.variables,functionToRun,args);
            }
        }
    }
}

package;

import sys.FileSystem;
import sys.io.File;
import flixel.FlxSprite;
import flixel.FlxG;

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

    public function runScript(pathToScript:String/*,?variablesToPass:Array<Array<Dynamic>>*/){
        if(!FileSystem.exists(pathToScript+".hx")){
            lime.app.Application.current.window.alert("No script found at "+pathToScript+".hx","Hscript Error!");
            return;
        }
        var rizzler = new hscript.Parser().parseString(File.getContent(pathToScript+".hx"));
        var script = new hscript.Interp();

        /*if(variablesToPass != null){
            for (variableTable in variablesToPass){
                script.variables.set(variableTable[0],variableTable[1]);
            }
        }*/

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

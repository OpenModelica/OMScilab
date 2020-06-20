# OMScilab
OpenModelica Scilab interface


# Requirement:
[Openmodelica](https://www.openmodelica.org/)<br>
[Scilab](https://www.scilab.org/)<br>
[zeromq/jeromq](https://github.com/zeromq/jeromq)<br>

The jeromq/zeromq library can be build by following the instructions in the repository, or the users can use the pre-build "jeromq-0.4.4-SNAPSHOT.jar" available in this repository and start using it straight away.

# Installation
Clone the repository and create configuration file "scilab.ini" file in SCIHOME directory, For Example <br>
```
from the scilab terminal,
--> SCIHOME
 SCIHOME  = 
  "C:\Users\arupa54\AppData\Roaming\Scilab\scilab-6.1.0"

will show the SCIHOME directory location and create a new configuration file "scilab.ini" and add the following two commands

javaclasspath("C:/OPENMODELICAGIT/OpenModelica/OMScilab/jeromq-0.4.4-SNAPSHOT.jar")
exec('C:\OPENMODELICAGIT\OpenModelica\OMScilab\OMScilab.sce', -1)

Note the path must be changed according to your location where you have downloaded.
the javaclasspath should be added in order to use the zeromq bindings in scilab alternatively the javaclasspath can also be added via terminal, but will not be available for 
future session and the next time when you open scilab you have to again load the javaclasspath for the zeromq bindings
```

# Usage
```
--> exec('C:\OPENMODELICAGIT\OpenModelica\OMScilab\OMScilab.sce', -1) // this can be done via scilab.ini also
--> omc=OMScilab();
--> sendExpression(omc, "getVersion()")
    "OpenModelica v1.16.0-dev-504-g895c6490e0 (64-bit)"
--> omc.sendExpression(omc, "model a end a;")
    "{a}"
--> sendExpression(omc, "loadFile(""C:/OPENMODELICAGIT/OpenModelica/OMCompiler/Examples/BouncingBall.mo"")")
    "true"
--> sendExpression(omc, "getClassNames()")
    {a,BouncingBall}
>>> sendExpression(omc, "simulate(BouncingBall)")
    "record SimulationResult
    resultFile = "C:/Users/arupa54/Documents/BouncingBall_res.mat",
    simulationOptions = "startTime = 0.0, stopTime = 1.0, numberOfIntervals = 500, tolerance = 1e-006, method = 'dassl', fileNamePrefix = 'BouncingBall', options = '', outputFormat = 'mat', variableFilter = '.*', cflags = '', simflags = ''",
    messages = "LOG_SUCCESS       | info    | The initialization finished successfully without homotopy method.
LOG_SUCCESS       | info    | The simulation finished successfully.
",
    timeFrontend = 0.0175727,
    timeBackend = 0.0521742,
    timeSimCode = 0.0133503,
    timeTemplates = 0.0493333,
    timeCompile = 9.613113,
    timeSimulation = 0.2236613,
    timeTotal = 9.9726137
end SimulationResult; "

>>> sendExpression(omc, quit())
```

To see the list of available OpenModelicaScripting API see    (https://www.openmodelica.org/doc/OpenModelicaUsersGuide/latest/scripting_api.html




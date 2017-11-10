#!/bin/sh

./build/scripts/obtain_dotnet.sh

export PATH=Binaries/dotnet-cli:$PATH

./build/scripts/restore.sh

dotnet restore Compilers.sln
# How to build  -f net461 only?
dotnet build Compilers.sln

# Mono tests execution packaging
mkdir -p mono-tests

# TODO: Need to copy from roslyn-binaries
cp Binaries/Debug/Dlls/CSharpCodeAnalysis/Microsoft.CodeAnalysis.CSharp.dll mono-tests/
cp Binaries/Debug/Dlls/CodeAnalysis/Microsoft.CodeAnalysis.dll mono-tests/
cp Binaries/Debug/Dlls/Scripting/Microsoft.CodeAnalysis.Scripting.dll mono-tests/
cp Binaries/Debug/Dlls/CSharpScripting/Microsoft.CodeAnalysis.CSharp.Scripting.dll mono-tests/
cp Binaries/Debug/Exes/csc/net46/System.Collections.Immutable.dll mono-tests/
cp Binaries/Debug/Exes/csc/net46/System.Reflection.Metadata.dll mono-tests/
cp Binaries/Debug/Exes/VBCSCompiler/net46/VBCSCompiler.exe mono-tests/

#TODO: Why some tests depend on it ?
cp Binaries/Debug/Exes/vbc/net46/Microsoft.CodeAnalysis.VisualBasic.dll  mono-tests/

cp Binaries/Debug/Dlls/CSharpCompilerTestUtilities/Roslyn.Compilers.CSharp.Test.Utilities.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities/net461/Roslyn.Test.Utilities.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities/net461/Microsoft.CodeAnalysis.Test.Resources.Proprietary.dll mono-tests/
cp Binaries/Debug/Dlls/CompilerTestResources/Roslyn.Compilers.Test.Resources.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities.Desktop/Microsoft.Metadata.Visualizer.dll mono-tests/
cp Binaries/Debug/Dlls/ScriptingTestUtilities/Microsoft.CodeAnalysis.Scripting.TestUtilities.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities/net461/Microsoft.CodeAnalysis.Test.Resources.Proprietary.dll mono-tests/
cp Binaries/Debug/Dlls/CSharpCompilerTestUtilities/Roslyn.Compilers.CSharp.Test.Utilities.dll mono-tests/
cp Binaries/Debug/Dlls/PdbUtilities/Roslyn.Test.PdbUtilities.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities/net461/Microsoft.DiaSymReader.dll mono-tests/
cp Binaries/Debug/UnitTests/CSharpScriptingTest/net461/Microsoft.DiaSymReader.Converter.dll mono-tests/
cp Binaries/Debug/Dlls/TestUtilities.Desktop/Roslyn.Test.Utilities.Desktop.dll mono-tests/

cp Binaries/Debug/UnitTests/CSharpCompilerEmitTest/Roslyn.Compilers.CSharp.Emit.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CSharpCodeStyleTests/net461/Microsoft.CodeAnalysis.CSharp.CodeStyle.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CSharpCompilerSymbolTest/net461/ref/Roslyn.Compilers.CSharp.Symbol.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CodeStyleTests/net461/Microsoft.CodeAnalysis.CodeStyle.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/ScriptingTest/net461/Microsoft.CodeAnalysis.Scripting.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CSharpCompilerSyntaxTest/net461/Roslyn.Compilers.CSharp.Syntax.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/VBCSCompilerTests/net461/Roslyn.Compilers.CompilerServer.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CSharpScriptingTest/net461/Microsoft.CodeAnalysis.CSharp.Scripting.UnitTests.??? mono-tests/
cp Binaries/Debug/UnitTests/CSharpCompilerSemanticTest/Roslyn.Compilers.CSharp.Semantic.UnitTests.??? mono-tests/

# TODO:
cp ../external/xunit-binaries/* mono-tests/

cd mono-tests/

XUNIT="mono --debug xunit.console.exe"

## Everything under src/Compilers/CSharp/Test

$XUNIT Roslyn.Compilers.CSharp.Syntax.UnitTests.dll
$XUNIT Roslyn.Compilers.CSharp.Semantic.UnitTests.dll
$XUNIT Roslyn.Compilers.CSharp.Symbol.UnitTests.dll
$XUNIT Roslyn.Compilers.CSharp.Emit.UnitTests.dll

$XUNIT Microsoft.CodeAnalysis.CSharp.Scripting.UnitTests.dll

## Pipes are not working
$XUNIT Roslyn.Compilers.CompilerServer.UnitTests.dll


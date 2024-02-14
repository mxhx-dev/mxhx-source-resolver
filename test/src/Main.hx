import byte.ByteData;
import haxe.io.Path;
import haxeparser.HaxeParser;
import sys.FileSystem;
import utest.Runner;
import utest.ui.Report;

class Main {
	public static function main():Void {
		var haxeStdPath = Sys.getEnv("HAXE_STD_PATH");
		if (haxeStdPath == null) {
			#if windows
			haxeStdPath = "C:/HaxeToolkit/haxe/std";
			#else
			haxeStdPath = "/usr/local/lib/haxe/std";
			#end
		}
		var classPaths = [haxeStdPath, Path.join([Sys.getCwd(), "src/fixtures"])];
		var parsed:Array<{pack:Array<String>, decls:Array<haxeparser.Data.TypeDecl>}> = [];
		var directories = classPaths.copy();
		while (directories.length > 0) {
			var currentDirectory = directories.shift();
			var fileNames:Array<String> = try {
				FileSystem.readDirectory(currentDirectory);
			} catch (e:Dynamic) {
				continue;
			};
			for (fileName in fileNames) {
				var filePath = Path.join([currentDirectory, fileName]);
				try {
					if (FileSystem.isDirectory(filePath)) {
						directories.push(filePath);
						continue;
					}
					if (!StringTools.endsWith(fileName, ".hx")) {
						continue;
					}
					var content = sys.io.File.getContent(filePath);
					var parser = new HaxeParser(ByteData.ofString(content), filePath);
					// some standard library classes use #error if certain flags aren't set
					parser.define("eval");
					var result = parser.parse();
					parsed.push(result);
				} catch (e:Dynamic) {
					// something went wrong, but we'll just skip it
				}
			}
		}

		var runner = new Runner();
		runner.addCase(new mxhx.resolver.source.MXHXSourceResolverQnameTest(parsed));
		runner.addCase(new mxhx.resolver.source.MXHXSourceResolverQnameFieldTest(parsed));
		runner.addCase(new mxhx.resolver.source.MXHXSourceResolverTagTypeTest(parsed));
		runner.addCase(new mxhx.resolver.source.MXHXSourceResolverTagFieldTypeTest(parsed));
		runner.addCase(new mxhx.resolver.source.MXHXSourceResolverTagFieldValueTypeTest(parsed));

		#if (html5 && playwright)
		// special case: see below for details
		setupHeadlessMode(runner);
		#else
		// a report prints the final results after all tests have run
		Report.create(runner);
		#end

		// don't forget to start the runner
		runner.run();
	}

	#if (js && playwright)
	/**
		Developers using continuous integration might want to run the html5
		target in a "headless" browser using playwright. To do that, add
		-Dplaywright to your command line options when building.

		@see https://playwright.dev
	**/
	private function setupHeadlessMode(runner:Runner):Void {
		new utest.ui.text.PrintReport(runner);
		var aggregator = new utest.ui.common.ResultAggregator(runner, true);
		aggregator.onComplete.add(function(result:utest.ui.common.PackageResult):Void {
			Reflect.setField(js.Lib.global, "utestResult", result);
		});
	}
	#end
}

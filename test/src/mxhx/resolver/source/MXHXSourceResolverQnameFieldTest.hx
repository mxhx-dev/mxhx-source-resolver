package mxhx.resolver.source;

import haxe.Resource;
import mxhx.symbols.IMXHXAbstractSymbol;
import mxhx.symbols.IMXHXClassSymbol;
import mxhx.symbols.IMXHXEnumSymbol;
import mxhx.symbols.IMXHXInterfaceSymbol;
import utest.Assert;
import utest.Test;

class MXHXSourceResolverQnameFieldTest extends Test {
	private var resolver:MXHXSourceResolver;
	private var parsed:Array<{pack:Array<String>, decls:Array<haxeparser.Data.TypeDecl>}>;

	public function new(parsed:Array<{pack:Array<String>, decls:Array<haxeparser.Data.TypeDecl>}>) {
		super();
		this.parsed = parsed;
	}

	public function setupClass():Void {
		resolver = new MXHXSourceResolver(parsed);

		var content = Resource.getString("mxhx-manifest");
		var xml = Xml.parse(content);
		var mappings:Map<String, String> = [];
		for (componentXml in xml.firstElement().elementsNamed("component")) {
			var xmlName = componentXml.get("id");
			var qname = componentXml.get("class");
			mappings.set(xmlName, qname);
		}
		resolver.registerManifest("https://ns.mxhx.dev/2024/tests", mappings);
	}

	public function testResolveAnyField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "any");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Any", resolvedField.type.qname);
	}

	public function testResolveArrayField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "array");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("Array<String>", resolvedField.type.qname);
	}

	public function testResolveBoolField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "boolean");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Bool", resolvedField.type.qname);
	}

	public function testResolveClassField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "type");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Class<Dynamic>", resolvedField.type.qname);
	}

	public function testResolveDateField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "date");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("Date", resolvedField.type.qname);
	}

	public function testResolveDynamicField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "struct");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Dynamic", resolvedField.type.qname);
	}

	public function testResolveERegField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "ereg");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("EReg", resolvedField.type.qname);
	}

	public function testResolveFloatField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "float");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Float", resolvedField.type.qname);
	}

	public function testResolveFunctionConstraintField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "func");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("haxe.Constraints.Function", resolvedField.type.qname);
	}

	public function testResolveFunctionSignatureField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "funcTyped");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("haxe.Constraints.Function", resolvedField.type.qname);
	}

	public function testResolveIntField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "integer");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Int", resolvedField.type.qname);
	}

	public function testResolveStringField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "string");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("String", resolvedField.type.qname);
	}

	public function testResolveUIntField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "unsignedInteger");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("UInt", resolvedField.type.qname);
	}

	public function testResolveXmlField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "xml");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("Xml", resolvedField.type.qname);
	}

	public function testResolveNullField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "canBeNull");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXAbstractSymbol);
		Assert.equals("Null<Float>", resolvedField.type.qname);
	}

	public function testResolveStrictlyTypedField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "strictlyTyped");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("fixtures.TestPropertiesClass", resolvedField.type.qname);
	}

	public function testResolveStrictlyTypedInterfaceField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "strictInterface");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXInterfaceSymbol);
		Assert.equals("fixtures.ITestPropertiesInterface", resolvedField.type.qname);
	}

	public function testResolveAbstractEnumValueField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "abstractEnumValue");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXEnumSymbol);
		Assert.equals("fixtures.TestPropertyAbstractEnum", resolvedField.type.qname);
	}

	public function testResolveEnumValueField():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "enumValue");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXEnumSymbol);
		Assert.equals("fixtures.TestPropertyEnum", resolvedField.type.qname);
	}

	public function testResolveClassFromModuleWithDifferentName():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.TestPropertiesClass");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "classFromModuleWithDifferentName");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		Assert.equals("fixtures.ModuleWithClassThatHasDifferentName.ThisClassHasADifferentNameThanItsModule", resolvedField.type.qname);
	}

	public function testResolveFieldWithTypeParameter():Void {
		var resolvedClass:IMXHXClassSymbol = cast resolver.resolveQname("fixtures.ArrayCollection");
		Assert.notNull(resolvedClass);
		Assert.isOfType(resolvedClass, IMXHXClassSymbol);
		var resolvedField = Lambda.find(resolvedClass.fields, field -> field.name == "array");
		Assert.notNull(resolvedField);
		Assert.notNull(resolvedField.type);
		Assert.isOfType(resolvedField.type, IMXHXClassSymbol);
		// TODO: fix the % that should be used only internally
		Assert.equals("Array<%>", resolvedField.type.qname);
	}
}

o = NetAddr.new("192.168.0.20", 8000);
~velocity = 64;
OSCFunc({|args|
	(args.size == 4).if({
		var chan = args[1].asInteger.asString;
		o.sendMsg("i/vkb_midi/" ++ chan ++ "/pitch", args[3].asInteger);
		o.sendMsg("i/vkb_midi/" ++ chan ++ "/note/" ++ args[2].asInteger.asString, ~velocity);
	});
}, "/72edo/noteOn");

OSCFunc({|args|
	o.sendMsg("i/vkb_midi/" ++ args[1].asInteger.asString ++ "/note/" ++ args[2].asInteger.asString, 0);
}, "/72edo/noteOff");
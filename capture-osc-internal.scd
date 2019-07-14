s.waitForBoot({
	SynthDef(\pm, {|baseNote = 440, tune = 0, amp = 0.0, pan = 0, gate = 0|
        var e = EnvGen.kr(Env.asr(0.067, 1, 0.1), gate),
		freq = (baseNote + tune).midicps,
        scale = freq.explin(40, 4000.0, 1.2, 0.6);
        Out.ar(0,
            Pan2.ar(
                PMOsc.ar(
                    freq,
                    freq,
                    Rand(0.28,0.33) * e * scale,
                    PMOsc.ar(
                        freq * 3,
                        freq * 4,
                        Rand(0.28,0.33) * e * scale,
                        0,
                        Rand(0.28,0.33) * e * scale
                    ),
                    amp * e
                ),
                pan
            )
        );
    }).send(s);
	s.sync;
	n = Array.fill(10, { Synth(\pm) });
	~velocity = 64;
	OSCFunc({|args|
		(args.size == 3).if({
			var chan = args[1].asInteger;
			n[chan - 1].set(\tune, (args[2].asInteger - 8192) / 8192);
		});
	}, "/72edo/pitchBend");

	OSCFunc({|args|
		(args.size == 3).if({
			var chan = args[1].asInteger;
			n[chan - 1].set(\baseNote, args[2].asInteger, \gate, 1, \amp, (~velocity / 127).squared);
		});
	}, "/72edo/noteOn");

	OSCFunc({|args|
		var chan = args[1].asInteger;
		n[chan - 1].set(\gate, 0);
	}, "/72edo/noteOff");
});
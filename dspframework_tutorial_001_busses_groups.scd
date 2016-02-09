s.boot;
s.queryAllNodes;
//Groups - Order of Operations
~g0 = Group.new(s);
~g1 = Group.after(~g0);
//Audio Busses
~b0 = Bus.audio(s);
//Synth Def
SynthDef(\micin, {
	arg micch=0, obs;
	var source;
	source = SoundIn.ar(micch);
	Out.ar(obs, source);
}).add;
SynthDef(\router, {
	arg ibs, obs;
	var source;
	source = In.ar(ibs);
	Out.ar(obs, source);
}).add;
//Synths
a = Synth( \micin, [\obs, 0], ~g0 );
a.set( \obs, ~b0 );
a.free;
b = Synth( \router, [\ibs, ~b0, \obs, 0], ~g1 );
b.set( \obs, ~b0 );
b.free;

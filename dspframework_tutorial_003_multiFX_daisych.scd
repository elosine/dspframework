s.boot;
s.queryAllNodes;
s.meter
(
//Groups - Order of Operations
~g0 = Group.new(s);
~g1 = Group.after(~g0);
~g2 = Group.after(~g1);
//Audio Busses
~b0 = Bus.audio(s);
~b1 = Bus.audio(s);
//Synth Def
//Template
/*
SynthDef(\template, {
	arg ibs, obs, amp=1,
	atk=0.02, rel=0.1, crv= -2, gate=1;
	var source, sig, env;
	env = EnvGen.ar( Env.asr(atk, 1, rel, crv), gate );
	source = In.ar(ibs);
	sig = FX(source);
	Out.ar(obs, sig*amp*env);
}).add;
*/


SynthDef(\bitcrush, {
	arg ibs, obs, amp=1,
	atk=0.02, rel=0.1, crv= -2, gate=1,
	rate=44100, bit=8;
	var source, sig, env;
	env = EnvGen.ar( Env.asr(atk, 1, rel, crv), gate );
	source = In.ar(ibs);
	sig = Decimator.ar(source, rate, bit);
	Out.ar(obs, sig*amp*env);
}).add;

SynthDef(\verb, {
	arg ibs, obs, amp=1,
	atk=0.02, rel=0.1, crv= -2, gate=1,
	t60=1 /*0.1-60*/, damp=0/*0-1*/,
	sz=1/*0.5-5*/, dif=0.707/*0-1*/;
	var source, sig, env;
	env = EnvGen.ar( Env.asr(atk, 1, rel, crv), gate );
	source = In.ar(ibs);
	sig = JPverb.ar(source, t60, damp, sz, dif);
	//sig = FreeVerb.ar(source, mix, rm, damp);
	Out.ar(obs, sig*amp*env);
}).add;

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
)
//Synths
a = Synth( \micin, [\obs, ~b0], ~g0 );
a.set( \obs, ~b0 );
a.free;
b = Synth( \verb, [\ibs, ~b0, \obs, 0], ~g2 );
b.set( \damp, 0, \dif, 0.8, \sz, 4, \obs, 0, \ibs, ~b1 );
b.free;
c = Synth( \bitcrush, [\ibs, ~b0, \obs, 0], ~g1);
c.set(\obs, 1, \bit, 4);

(
~kb0 = Bus.control(s);
w = Window.new(bounds:Rect(100,1000,50,200)).layout_(HLayout(Slider().action_({|sl|~kb0.set(sl.value)}

))).front;
)

~kb0.get
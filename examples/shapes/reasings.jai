/* ******************************************************************************************
*
*   reasings - raylib easings library, based on Robert Penner library
*
*   Useful easing functions for values animation
*
*   This header uses:
*       #define REASINGS_STATIC_INLINE      // Inlines all functions code, so it runs faster.
*                                           // This requires lots of memory on system.
*   How to use:
*   The four inputs t,b,c,d are defined as follows:
*   t = current time (in any unit measure, but same unit as duration)
*   b = starting value to interpolate
*   c = the total change in value of b that needs to occur
*   d = total time it should take to complete (duration)
*
*   Example:
*
*   currentTime := 0;
*   duration := 100;
*   startPositionX := 0.0;
*   finalPositionX := 30.0;
*   currentPositionX := startPositionX;
*
*   while (currentPositionX < finalPositionX)
*   {
*       currentPositionX = EaseSineIn(currentTime, startPositionX, finalPositionX - startPositionX, duration);
*       currentTime+= 1;
*   }
*
*   A port of Robert Penner's easing equations to C (http://robertpenner.com/easing/)
*
*   Robert Penner License
*   ---------------------------------------------------------------------------------
*   Open source under the BSD License.
*
*   Copyright (c) 2001 Robert Penner. All rights reserved.
*
*   Redistribution and use in source and binary forms, with or without modification,
*   are permitted provided that the following conditions are met:
*
*       - Redistributions of source code must retain the above copyright notice,
*         this list of conditions and the following disclaimer.
*       - Redistributions in binary form must reproduce the above copyright notice,
*         this list of conditions and the following disclaimer in the documentation
*         and/or other materials provided with the distribution.
*       - Neither the name of the author nor the names of contributors may be used
*         to endorse or promote products derived from this software without specific
*         prior written permission.
*
*   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
*   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
*   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
*   IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
*   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*   BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
*   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
*   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
*   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
*   OF THE POSSIBILITY OF SUCH DAMAGE.
*   ---------------------------------------------------------------------------------
*
*   Copyright (c) 2015-2024 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/



EaseLinearNone  :: (t: float, b: float, c: float, d: float) -> float { return (c*t/d + b); }
EaseLinearIn    :: (t: float, b: float, c: float, d: float) -> float { return (c*t/d + b); }
EaseLinearOut   :: (t: float, b: float, c: float, d: float) -> float { return (c*t/d + b); }
EaseLinearInOut :: (t: float, b: float, c: float, d: float) -> float { return (c*t/d + b); }

// Sine Easing functions
EaseSineIn    :: (t: float, b: float, c: float, d: float) -> float { return (-c*Math.cos(t/d*(Math.PI/2.0)) + c + b); }
EaseSineOut   :: (t: float, b: float, c: float, d: float) -> float { return (c*Math.sin(t/d*(Math.PI/2.0)) + b); }
EaseSineInOut :: (t: float, b: float, c: float, d: float) -> float { return (-c/2.0*(Math.cos(Math.PI*t/d) - 1.0) + b); }

// Circular Easing functions
EaseCircIn  :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d;
	return -c*(Math.sqrt(1.0 - u*u) - 1.0) + b;
}
EaseCircOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u = u/d - 1.0;
	return c*Math.sqrt(1.0 - u*u) + b;
}
EaseCircInOut :: (t: float, b: float, c: float, d: float) -> float  {
	u := t;
	u /= d/2.0;
	if u < 1.0 {
		return -c/2.0*(Math.sqrt(1.0 - u*u) - 1.0) + b;
	}
	u -= 2.0;
	return c/2.0*(Math.sqrt(1.0 - u*u) + 1.0) + b;
}

// Cubic Easing functions
EaseCubicIn :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d;
	return c*u*u*u + b;
}
EaseCubicOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u = u/d - 1.0;
	return c*(u*u*u + 1.0) + b;
}
EaseCubicInOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d/2.0;
	if u < 1.0 {
		return c/2.0*u*u*u + b;
	}
	u -= 2.0;
	return c/2.0*(u*u*u + 2.0) + b;
}

// Quadratic Easing functions
EaseQuadIn :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d;
	return c*u*u + b;
}
EaseQuadOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d;
	return -c*u*(u - 2.0) + b;
}
EaseQuadInOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d/2.0;
	if u < 1 {
		return ((c/2)*(u*u)) + b;
	}
	return -c/2.0*(((u - 1.0)*(u - 3.0)) - 1.0) + b;
}

// Exponential Easing functions
EaseExpoIn :: (t: float, b: float, c: float, d: float) -> float {
	return ifx (t == 0.0) then b else (c*Math.pow(2.0, 10.0*(t/d - 1.0)) + b);
}
EaseExpoOut :: (t: float, b: float, c: float, d: float) -> float {
	return ifx (t == d) then (b + c) else (c*(-Math.pow(2.0, -10.0*t/d) + 1.0) + b);
}
EaseExpoInOut :: (t: float, b: float, c: float, d: float) -> float {
	if t == 0.0 {
		return b;
	}
	if t == d {
		return b + c;
	}
	u := t;
	u /= d/2.0;
	if u < 1.0 {
		return c/2.0*Math.pow(2.0, 10.0*(u - 1.0)) + b;
	}

	return c/2.0*(-Math.pow(2.0, -10.0*(u - 1.0)) + 2.0) + b;
}

// Back Easing functions
EaseBackIn :: (t: float, b: float, c: float, d: float) -> float {
	s :: 1.70158;
	u := t;
	u /= d;
	postFix := u;
	return (c*(postFix)*u*((s + 1.0)*u - s) + b);
}

EaseBackOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	s :: 1.70158;
	u = u/d - 1.0;
	return (c*(u*u*((s + 1.0)*u + s) + 1.0) + b);
}

EaseBackInOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	s := cast(float) 1.70158;
	u /= d/2;
	if u < 1.0 {
		s *= 1.525;
		return (c/2.0*(u*u*((s + 1.0)*u - s)) + b);
	}

	u -= 2;
	postFix := u;
	s *= 1.525;
	return (c/2.0*((postFix)*u*((s + 1.0)*u + s) + 2.0) + b);
}

// Bounce Easing functions
EaseBounceOut :: (t: float, b: float, c: float, d: float) -> float {
	u := t;
	u /= d;
	if u < 1.0/2.75 {
		return (c*(7.5625*u*u) + b);
	} else if u < 2.0/2.75 {
		u -= 1.5/2.75;
		postFix := u;
		return (c*(7.5625*(postFix)*u + 0.75) + b);
	} else if u < 2.5/2.75 {
		u -= 2.25/2.75;
		postFix := u;
		return (c*(7.5625*(postFix)*u + 0.9375) + b);
	} else {
		u -= 2.625/2.75;
		postFix := u;
		return (c*(7.5625*(postFix)*u + 0.984375) + b);
	}
}

EaseBounceIn :: (t: float, b: float, c: float, d: float) -> float {
	return c - EaseBounceOut(d - t, 0.0, c, d) + b;
}
EaseBounceInOut :: (t: float, b: float, c: float, d: float) -> float {
	if t < d/2.0 {
		return EaseBounceIn(t*2.0, 0.0, c, d)*0.5 + b;
	} else {
		return EaseBounceOut(t*2.0 - d, 0.0, c, d)*0.5 + c*0.5 + b;
	}
}

// Elastic Easing functions
EaseElasticIn :: (t: float, b: float, c: float, d: float) -> float {
	if t == 0.0 {
		return b;
	}
	u := t;
	u /= d;
	if u == 1.0 {
		return b + c;
	}

	p := d*0.3;
	a := c;
	s := p/4.0;
	u -= 1;
	postFix := a*Math.pow(2.0, 10.0*u);

	return -(postFix*Math.sin((u*d-s)*(2.0*Math.PI)/p )) + b;
}

EaseElasticOut :: (t: float, b: float, c: float, d: float) -> float {
	if t == 0.0 {
		return b;
	}
	u := t;
	u /= d;
	if u == 1.0 {
		return b + c;
	}

	p := d*0.3;
	a := c;
	s := p/4.0;

	return a*Math.pow(2.0,-10.0*u)*Math.sin((u*d-s)*(2.0*Math.PI)/p) + c + b;
}

EaseElasticInOut :: (t: float, b: float, c: float, d: float) -> float {
	if t == 0.0 {
		return b;
	}
	u := t;
	u /= d/2.0;
	if u == 2.0 {
		return b + c;
	}

	p := d*(0.3*1.5);
	a := c;
	s := p/4.0;

	u -= 1;
	if u < 1.0 {
		postFix := a*Math.pow(2.0, 10.0*u);
		return -0.5*(postFix*Math.sin((u*d-s)*(2.0*Math.PI)/p)) + b;
	}

	postFix := a*Math.pow(2.0, -10.0*u);
	return (postFix*Math.sin((u*d-s)*(2.0*Math.PI)/p)*0.5 + c + b);
}

#scope_file

Math :: #import "Math";

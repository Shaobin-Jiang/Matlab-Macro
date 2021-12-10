#include "mex.h"
#include <windows.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	double *x;
	if(nrhs != 1) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs", "Matlab-Macro Error: One input argument required!");
	}
	if(nlhs > 0) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs", "Matlab-Macro Error: No output allowed!");
	}
	x = mxGetPr(prhs[0]);
	switch ((int)*x) {
		case 1: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); break;
		case 2: mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0); break;
		case 3: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0); break;
		case 4: mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0); break;
		case 5: mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0); break;
		case 6: mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0); break;
		case 7: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0); break;
		case 8: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0); break;
		case 9: mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0); break;
		case 10: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0); mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0); break;
	}
}

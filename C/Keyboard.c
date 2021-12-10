#include <windows.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	double *x, *y;
	if(nrhs != 2) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs", "Matlab-Macro Error: Two input arguments required!");
	}
	if(nlhs > 0) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs", "Matlab-Macro Error: No output allowed!");
	}
	x = mxGetPr(prhs[0]);
	y = mxGetPr(prhs[1]);
	switch ((int)*y) {
		case 1: keybd_event((int)*x, 0, 0, 0); break; // Key down
		case 2: keybd_event((int)*x, 0, 2, 0); break; // Key up
		case 3: keybd_event((int)*x, 0, 0, 0); keybd_event((int)*x, 0, 2, 0); break; // Key press
	}
}

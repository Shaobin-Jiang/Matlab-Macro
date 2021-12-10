#include "mex.h"
#include <windows.h>

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
	SetCursorPos((int)*x, (int)*y);
}

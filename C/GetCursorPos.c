#include <windows.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    if(nrhs != 0) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs", "Matlab-Macro Error: No input argument required!");
	}
	if(nlhs > 1) {
	    mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nlhs", "Matlab-Macro Error: A maximum of one output allowed!");
	}
    POINT ptB = {0, 0};
    LPPOINT xy = &ptB;
    GetCursorPos(xy);
    plhs[0] = mxCreateDoubleMatrix(1, 2, mxREAL);
    *(mxGetPr(plhs[0]) + 0) = xy -> x;
    *(mxGetPr(plhs[0]) + 1) = xy -> y;
}

// void main() {
//     POINT ptB = {0, 0};
//     LPPOINT xy = &ptB;
//     GetCursorPos(xy);
//     printf("%d", (int)(xy -> x));
// }
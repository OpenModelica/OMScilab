// This file is part of OpenModelica.
// Copyright (c) 1998-CurrentYear, Open Source Modelica Consortium (OSMC),
// c/o Linköpings universitet, Department of Computer and Information Science,
// SE-58183 Linköping, Sweden.
//
// All rights reserved.
//
// THIS PROGRAM IS PROVIDED UNDER THE TERMS OF THE BSD NEW LICENSE OR THE
// GPL VERSION 3 LICENSE OR THE OSMC PUBLIC LICENSE (OSMC-PL) VERSION 1.2.
// ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES
// RECIPIENT'S ACCEPTANCE OF THE OSMC PUBLIC LICENSE OR THE GPL VERSION 3,
// ACCORDING TO RECIPIENTS CHOICE.
//
// The OpenModelica software and the OSMC (Open Source Modelica Consortium)
// Public License (OSMC-PL) are obtained from OSMC, either from the above
// address, from the URLs: http://www.openmodelica.org or
// http://www.ida.liu.se/projects/OpenModelica, and in the OpenModelica
// distribution. GNU version 3 is obtained from:
// http://www.gnu.org/copyleft/gpl.html. The New BSD License is obtained from:
// http://www.opensource.org/licenses/BSD-3-Clause.
//
// This program is distributed WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, EXCEPT AS
// EXPRESSLY SET FORTH IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE
// CONDITIONS OF OSMC-PL.


jimport org.zeromq.ZMQ;

function this = OMScilab()
    this.filedata="";
    this.context = ZMQ.context(1);
    this.requester = this.context.socket(ZMQ.REQ);
    fileid=rand();
    this.portfile=strcat([fileparts(TMPDIR),"openmodelica.port.",string(fileid)])
    // start the omc process with zmq
    if getos() == 'Windows' then
        cmd=strcat(["start /b ", fullfile(getenv('OPENMODELICAHOME'), "bin", "omc.exe"), " --interactive=zmq +z=", string(fileid)])
        //disp(cmd);
        unix(cmd);
    else
        cmd=strcat(["omc --interactive=zmq +z=", string(fileid), " &"])
        unix(cmd);
    end;

    while 1,
        sleep(0.05);
        if(isfile(this.portfile))
            this.filedata = mgetl(this.portfile, 5);
            break;
        end
    end
    this.requester.connect(this.filedata);
endfunction

// pass the OpenModelica API , as strings and returns the results as strings
function result = sendExpression(this, expr)
    this.requester.send(expr,0);
    result = return(this.requester.recvStr(0));
endfunction

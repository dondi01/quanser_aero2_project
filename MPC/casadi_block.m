classdef casadi_block < matlab.System & matlab.system.mixin.Propagates
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    properties
        % Public, tunable properties.

    end

    properties (DiscreteState)
    end

    properties (Access = private)
        % Pre-computed constants.
        casadi_solver
        x0
        lbx
        ubx
        lbg
        ubg
    end

    methods (Access = protected)
        function num = getNumInputsImpl(~)
            num = 2;
        end
        function num = getNumOutputsImpl(~)
            num = 1;
        end
        function dt1 = getOutputDataTypeImpl(~)
        	dt1 = 'double';
        end
        function dt1 = getInputDataTypeImpl(~)
        	dt1 = 'double';
        end
        function sz1 = getOutputSizeImpl(~)
        	sz1 = [1,1];
        end
        function sz1 = getInputSizeImpl(~)
        	sz1 = [1,1];
        end
        function cp1 = isInputComplexImpl(~)
        	cp1 = false;
        end
        function cp1 = isOutputComplexImpl(~)
        	cp1 = false;
        end
        function fz1 = isInputFixedSizeImpl(~)
        	fz1 = true;
        end
        function fz1 = isOutputFixedSizeImpl(~)
        	fz1 = true;
        end
        function setupImpl(obj,~,~)
            % Implement tasks that need to be performed only once, 
            % such as pre-computed constants.
            
            import casadi.*
            
            Mb = 1.07;
            Dm = 0.00240;
            Jp = 0.0232;
            g = 9.81;
            Dt = 0.167;
            C=0.001763;
            beta=0.0000037343;

            T = 1; % Time horizon
            N = 10; % number of control intervals

            % Declare model variables
            x1 = SX.sym('x1');
            x2 = SX.sym('x2');
            x3= SX.sym('x3');
            x4=SX.sym('x4');
            x = [x1; x2; x3;x4];

            u = SX.sym('u');
            
            % Model equations
            xdot = [x2; 1/Jp*( ...
            beta*(u^2*sign(u)*2)*Dt ...
            -C*x2 ...
            -Mb*g*Dm*sin(x1));0;0];

            % Objective term
            L =(x1-x3)^2;

            % Continuous time dynamics
            f = casadi.Function('f', {x, u}, {xdot, L});

            % Formulate discrete time dynamics
            % Fixed step Runge-Kutta 4 integrator
            M = 1; % RK4 steps per interval
            DT = T/N/M;
            f = Function('f', {x, u}, {xdot, L});
            X0 = MX.sym('X0', 4);
            U = MX.sym('U');
            X = X0;
            Q = 0;
            for j=1:M
               [k1, k1_q] = f(X, U);
               [k2, k2_q] = f(X + DT/2 * k1, U);
               [k3, k3_q] = f(X + DT/2 * k2, U);
               [k4, k4_q] = f(X + DT * k3, U);
               X=X+DT/6*(k1 +2*k2 +2*k3 +k4);
               Q = Q + DT/6*(k1_q + 2*k2_q + 2*k3_q + k4_q);
            end

            F = Function('F', {X0, U}, {X, Q}, {'x0','p'}, {'xf', 'qf'});

            % Start with an empty NLP
            w={};
            w0 = [];
            lbw = [];
            ubw = [];
            J = 0;
            g={};
            lbg = [];
            ubg = [];

            % "Lift" initial conditions
            X0 = MX.sym('X0', 4);
            w = {w{:}, X0};
            lbw = [lbw; -inf;-inf;-inf;-inf];
            ubw = [ubw; inf;inf;inf;inf];
            w0 = [w0; 0; 0; 0; 0];

            % Formulate the NLP
            Xk = X0;
            for k=0:N-1
                % New NLP variable for the control
                Uk = MX.sym(['U_' num2str(k)]);
                w = {w{:}, Uk};
                lbw = [lbw; -270];
                ubw = [ubw;  270];
                w0 = [w0;200];

                % Integrate till the end of the interval
                Fk = F('x0', Xk, 'p', Uk);
                Xk_end = Fk.xf;
                J=J+Fk.qf;

                % New NLP variable for state at end of interval
                Xk = MX.sym(['X_' num2str(k+1)], 4);
                w = {w{:}, Xk};
                lbw = [lbw; -inf; -inf;-inf;-inf];
                ubw = [ubw;  inf;  inf; inf;inf];
                w0 = [w0; 0; 0; 0; 0];

                % Add equality constraint
                g = {g{:}, Xk_end-Xk};
                lbg = [lbg; 0; 0;0; 0];
                ubg = [ubg; 0; 0;0; 0];
            end

            % Create an NLP solver
            prob = struct('f', J, 'x', vertcat(w{:}), 'g', vertcat(g{:}));
            options = struct('ipopt',struct('print_level',0),'print_time',false);
            solver = nlpsol('solver', 'ipopt', prob, options);

            obj.casadi_solver = solver;
            obj.x0 = w0;
            obj.lbx = lbw;
            obj.ubx = ubw;
            obj.lbg = lbg;
            obj.ubg = ubg;
        end

        function u = stepImpl(obj,x,t)
            w0 = obj.x0;
            lbw = obj.lbx;
            ubw = obj.ubx;
            solver = obj.casadi_solver;
            lbw(1:4) = x;
            ubw(1:4) = x;

            sol = solver('x0', w0, 'lbx', lbw, 'ubx', ubw,...
                        'lbg', obj.lbg, 'ubg',obj.ubg);
  
            u = full(sol.x(5));
        end

        function resetImpl(obj)
            % Initialize discrete-state properties.
        end
    end
end

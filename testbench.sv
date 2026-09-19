// testbench.sv
// Genera reloj, aplica estimulos, y verifica que top.sv se comporte
// como se espera: cambios de estado, colores de luz, y reaccion Mealy

module testbench();

    logic clk;
    logic reset;
    logic trafico_a, trafico_b, n, p;
    logic [1:0] luz_a, luz_b;
    logic walk, dontwalk;

    // ---- Instancia del DUT (Device Under Test) ----
    top dut (
        .clk        (clk),
        .reset      (reset),
        .trafico_a  (trafico_a),
        .trafico_b  (trafico_b),
        .n          (n),
        .p          (p),
        .luz_a      (luz_a),
        .luz_b      (luz_b),
        .walk       (walk),
        .dontwalk   (dontwalk)
    );

    // ---- Generador de reloj: periodo de 10ns ----
    always
        begin
            clk = 1'b0; #5;
            clk = 1'b1; #5;
        end

    // ---- Secuencia de estimulos ----
    initial begin
        // Reinicio limpio
        reset = 1'b1; trafico_a = 1'b0; trafico_b = 1'b0; n = 1'b0; p = 1'b0;
        @(posedge clk); @(posedge clk);
        reset = 1'b0;

        // S0 -> S1 (Trafico_B activa la salida de A)
        trafico_b = 1'b1;
        @(posedge clk);
        trafico_b = 1'b0;

        // S1 -> S2 (incondicional)
        @(posedge clk);

        // En S2 (todo rojo): probar la reaccion Mealy del boton peatonal
        p = 1'b1;
        #2; // deja tiempo para que la logica combinacional reaccione (sin flanco de reloj)
        p = 1'b0;

        // S2 -> S3 (incondicional)
        @(posedge clk);

        // S3 -> S4 (Trafico_A activa el cambio)
        trafico_a = 1'b1;
        @(posedge clk);
        trafico_a = 1'b0;

        // S4 -> S5 (incondicional)
        @(posedge clk);

        // S5 -> S0 (incondicional)
        @(posedge clk);

        // Probar modo nocturno
        n = 1'b1;
        @(posedge clk);
        n = 1'b0;

        #20;
        $stop;
    end

endmodule

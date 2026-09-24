// moore.sv
// FSM Moore: controla el ciclo de luces del semaforo (7 estados)
// Migrado desde moore_semaforo_block (Logisim) — registro de estado +
// moore_next_state_logic + moore_output_logic

module moore (
    input  logic       clk,
    input  logic       reset,
    input  logic        trafico_a,
    input  logic        trafico_b,
    input  logic        n,
    output logic [1:0]  luz_a,
    output logic [1:0]  luz_b,
    output logic [2:0]  estado   // se exporta hacia mealy.sv
);

    logic [2:0] state, next_state;

    // ---- Registro de estado (equivalente a los 3 biestables D) ----
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    // ---- Logica de proximo estado (moore_next_state_logic) ----
    assign next_state[2] = (state[0] & state[1] & n) |
                            (state[0] & state[1] & trafico_a) |
                            (state[2] & n & ~state[0]) |
                            (state[2] & ~state[0] & ~state[1]) |
                            (n & ~state[0] & ~state[1]);

    assign next_state[1] = (state[1] & n) |
                            (n & ~state[2]) |
                            (state[0] & ~state[1] & ~state[2]) |
                            (state[0] & ~state[2] & ~trafico_a) |
                            (state[1] & ~state[0] & ~state[2]);

    assign next_state[0] = (state[1] & ~state[0] & ~state[2]) |
                            (state[2] & ~state[0] & ~state[1]) |
                            (state[1] & ~state[2] & ~n & ~trafico_a) |
                            (trafico_b & ~state[0] & ~state[2] & ~n);

    // ---- Logica de salida (moore_output_logic) ----
    // Codificacion: 10 = verde, 01 = amarillo, 00 = rojo
    assign luz_a[1] = ~state[0] & ~state[1] & ~state[2];
    assign luz_a[0] = (state[1] & state[2]) | (state[0] & ~state[1] & ~state[2]);

    assign luz_b[1] = state[0] & state[1];
    assign luz_b[0] = state[2] & ~state[0];

    assign estado = state;

endmodule
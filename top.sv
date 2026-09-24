// top.sv
// Modulo de mas alto nivel: instancia la FSM Moore (semaforo) y la FSM
// Mealy (cruce peatonal), y las conecta entre si mediante la senal "estado"

module top (
    input  logic       clk,
    input  logic       reset,
    input  logic        trafico_a,
    input  logic        trafico_b,
    input  logic        n,
    input  logic        p,
    output logic [1:0]  luz_a,
    output logic [1:0]  luz_b,
    output logic        walk,
    output logic        dontwalk
);

    logic [2:0] estado_interno;

    // ---- Instancia de la FSM Moore (subproceso 2: semaforo) ----
    moore moore_inst (
        .clk        (clk),
        .reset      (reset),
        .trafico_a  (trafico_a),
        .trafico_b  (trafico_b),
        .n          (n),
        .luz_a      (luz_a),
        .luz_b      (luz_b),
        .estado     (estado_interno)
    );

    // ---- Instancia de la FSM Mealy (subproceso 1: cruce peatonal) ----
    mealy mealy_inst (
        .estado     (estado_interno),
        .p          (p),
        .walk       (walk),
        .dontwalk   (dontwalk)
    );

endmodule
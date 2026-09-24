// mealy.sv
// FSM Mealy: controla el cruce peatonal
// Migrado desde mealy_peatonal_block (Logisim) — puramente combinacional,
// la salida depende del estado del semaforo Y del boton P al mismo tiempo

module mealy (
    input  logic [2:0] estado,   // viene de moore.sv
    input  logic        p,        // boton peatonal
    output logic        walk,
    output logic        dontwalk
);

    // Walk = 1 solo si el estado es S2 (010) o S5 (101) Y ademas P=1
    assign walk = (estado[0] & estado[2] & p) |
                  (estado[1] & p & ~estado[0] & ~estado[2]);

    assign dontwalk = ~p |
                       (estado[0] & ~estado[2]) |
                       (estado[2] & ~estado[0]) |
                       (~estado[1] & ~estado[2]);

endmodule
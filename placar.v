module placar(btn, sinal, saida, clk, clkG, alerta, reset, resetar, pause, blocos, buzer);
	
	input sinal, clk, clkG; // sinal que interfere na operação de soma e input que ta pinada no clock da placa
	wire  cin, cout; // carregador do somador/subtrator
	wire [0:11] T, cronos; // fios que receberam o vetores de bits para formar o bcd a partir do conversor
	wire [0:6] s; // fios que representam o numero binario
	wire [0:15] set, setcronos; // saida do 7 segmentos
	input reset, resetar, pause; // Entradas para limitar, pausar e zerar o contador
	output [0:3] blocos; // Blocos responsaveis por ligar o display de 7 seguimentos
	input [0:2] btn; // inputs pinados nos botões da placa
	output [0:6]  saida; // saida pinada nos segmentos do visor de 7 segmentos
	output alerta; // alerta que retornara 1 quando o comparador atestar um numero maior que 99
	// clock em 2 estados para usar no tristate e no visor de 7 segmentos
	output buzer;
	
	
	
	//defini as 12 posições para o numero 99 em BCD
	wire [0:11] noventaenove;
	or or994(noventaenove[0], 1);
	or or997(noventaenove[3], 1);
	or or998(noventaenove[4], 1);
	or or9911(noventaenove[7], 1);
	//fio para saida do circuito do botão
	wire[0:6] pontos;
	wire invs, sinalbtn,clkatraso;
	not notsinal(invs, sinal);
	wire [0:11] comp; 
	
	
	// Valor do botão clicado é definido
	pontuar(btn, pontos[0], pontos[1]);
	nor or0(sinalbtn, btn[0], btn[1], btn[2]);
	debouncer(sinalbtn,clkatraso); // atraso no sinal do botão ultilizando flip flops para ser usado no registrador
	
	//(Soma para nivel logico baixo e subtração para nivel logico alto)
	// Mantenha o botão precionado e as chaves para cima 
	// valores de entrada e de saida são dados na ordem inversa. (Baixo para cima, direita pra esquerda)
	acumulador7b(invs, pontos,  cin, cout, clkG, s);
	
	//Bloco dedicado ao contador
	wire [0:6] tempo; //Saidas do contador
	wire [0:6] quartA, vintA, quartB, vintB;
	wire buzerA, buzerB;
	
	//pause - variavel que se estiver em nivel logico baixo fara o contador parar de contar o tempo
	// clkG - sinal de clock que vira do gerador de forma de onda na faixa de 1HZ
	// resetar - pinado no botão da placa pra reiniciar o contador
	// quartA e vintA - Saida Q dos flipflops
	// quartB e vintB - Saida QB dos flipflops
	contador5bits14(pause, clkG, resetar, quartA, quartB, buzerA);
	contador5bits(pause, clkG, resetar, vintA, vintB, buzerB);
	or orbuzer(buzer, buzerA, buzerB);
	//Defini qual dos dois contadores sera exibido a partir do valor de uma das chaves da placa
	// Nivel logico baixo para o 14 e nivel logico alto para o 24 
	muxP(quartA[0], 0, 0, vintA[0], reset, reset, tempo[0]);
	muxP(quartA[1], 0, 0, vintA[1], reset, reset, tempo[1]);
	muxP(quartA[2], 0, 0, vintA[2], reset, reset, tempo[2]);
	muxP(quartA[3], 0, 0, vintA[3], reset, reset, tempo[3]);
	muxP(quartA[4], 0, 0, vintA[4], reset, reset, tempo[4]);
	muxP(quartA[5], 0, 0, vintA[5], reset, reset, tempo[5]);
	muxP(quartA[6], 0, 0, vintA[6], reset, reset, tempo[6]);
	
	
	

	
	
	
	//converte o valor binario em bcd. Entrada é dada na ordem inversa por causa da saida do somador
	// saida na ordem normal
	// saida do contador como entrada para retornar o bcd correspondente
	binario_bcd(tempo[6], tempo[5], tempo[4], tempo[3], tempo[2], tempo[1], tempo[0], cronos[0], cronos[1], cronos[2], cronos[3], cronos[4], cronos[5], cronos[6], cronos[7], cronos[8], cronos[9], cronos[10], cronos[11]);
	// saida do somador como entrada para retornar o bcd correspondente
	binario_bcd(s[6], s[5], s[4], s[3], s[2], s[1], s[0], T[0], T[1], T[2], T[3], T[4], T[5], T[6], T[7], T[8], T[9], T[10], T[11]);
	
	
	//invertendo valores para passar como entrada do comparador bcd que verifica se A>B com A sendo o bcd do resultado da soma e B sendo 99 em bcd
	or ort0(comp[11], T[0]);
	or ort1(comp[10], T[1]);
	or ort2(comp[9], T[2]);
	or ort3(comp[8], T[3]);
	or ort4(comp[7], T[4]);
	or ort5(comp[6], T[5]);
	or ort6(comp[5], T[6]);
	or ort7(comp[4], T[7]);
	or ort8(comp[3], T[8]);
	or ort9(comp[2], T[9]);
	or ort10(comp[1], T[10]);
	or ort11(comp[0], T[11]);
	// compara se A>B e retorna nivel logico alto
	comparador_bcd_24_bits(comp,noventaenove, alerta);
	
	// entradas e saidas das casas de unidade e dezena do cronometro que são convertidas de bcd para saidas em 7 segmentos
	bcd7segs (cronos[4], cronos[5], cronos[6], cronos[7], setcronos[6], setcronos[5], setcronos[4], setcronos[3], setcronos[2], setcronos[1], setcronos[0]);
	bcd7segs (cronos[8], cronos[9], cronos[10], cronos[11], setcronos[13], setcronos[12], setcronos[11], setcronos[10], setcronos[9], setcronos[8], setcronos[7]);
	
	// entradas e saidas das casas de unidade e dezena do placa que são convertidas de bcd para saidas em 7 segmentos
	bcd7segs (T[4], T[5], T[6], T[7], set[6], set[5], set[4], set[3], set[2], set[1], set[0]);
	bcd7segs (T[8], T[9], T[10], T[11], set[13], set[12], set[11], set[10], set[9], set[8], set[7]);
	//tristates que comparam os valores dos dois decodificadores bcd e retorna uma das entradas como saida
	// Se clock tiver em 1 e clock barrado tiver em 0 a saida A tera passagem e se o clock tiver em 0 e seu barramento em 1 a saida B tera vez
	wire[0:17] Q, QB;
	divisorFreq(clk, Q, QB); // recebe o clk da placa e retorna um vetor de 17 posições
	// Q e QB são as saidas do divisor de frequencia eles estão retornando dois clocks diferentes um equivalente ao clk dividido por 2 a 17 e o outro divido por 2 a 16.
	demuxP(0, Q[17], QB[16], blocos[0], blocos[1], blocos[2], blocos[3]); // A cada pulso de clock alterna uma das saidas para nivel logico baixo e deixa o resto em alto(Função: Ligar cada bloco de dysplay individualmente)
	
	
	//Cada mux enviara um dos quatro valores possiveis para o visor de 7 segmentos. Esse valor é o vetor de saida
	// As 4 Primeiras variaveis correspondem respectivamente a: Dezena do placar, unidade do placar, dezena do contador e unidade do contador
	// Q e QB são as saidas do divisor de frequencia eles estão retornando dois clocks diferentes um equivalente ao clk dividido por 2 a 17 e o outro divido por 2 a 16.
	muxP(set[6], set[13], setcronos[6], setcronos[13], Q[17], QB[16], saida[0]);
	muxP(set[5], set[12], setcronos[5], setcronos[12], Q[17], QB[16], saida[1]);
	muxP(set[4], set[11], setcronos[4], setcronos[11], Q[17], QB[16], saida[2]);
	muxP(set[3], set[10], setcronos[3], setcronos[10], Q[17], QB[16], saida[3]);
	muxP(set[2], set[9], setcronos[2], setcronos[9], Q[17], QB[16], saida[4]);
	muxP(set[1], set[8], setcronos[1], setcronos[8], Q[17], QB[16], saida[5]);
	muxP(set[0], set[7], setcronos[0], setcronos[7], Q[17], QB[16], saida[6]);
	
endmodule 
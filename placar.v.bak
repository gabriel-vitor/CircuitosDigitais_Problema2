module placar(btn, chave, sinal, saida, clk, sclk, alerta,ch, desl);
	output [0:1] sclk; // saida pinada nas entradas que ativam os dois primeiros blocos do visor de 7 segmentos
	input sinal, clk; // sinal que interfere na operação de soma e input que ta pinada no clock da placa
	wire  cin, cout; // carregador do somador/subtrator
	wire [0:11] T; // fios que receberam o vetores de bits para formar o bcd a partir do conversor
	wire [0:6] s; // fios que representam o numero binario
	wire [0:15] set; // saida do 7 segmentos
	input [0:6] chave; // chave que formara um numero qualquer dependendo de quais sejam ativadas
	input ch; // chave que mandara sempre o numero 99 quando ativa
	input [0:2] btn; // inputs pinados nos botões da placa
	output [0:6] saida; // saida pinada nos segmentos do visor de 7 segmentos
	output alerta; // alerta que retornara 1 quando o comparador atestar um numero maior que 99
	// clock em 2 estados para usar no tristate e no visor de 7 segmentos
	output [0:1] desl;
	not not0(sclk[1], clk);
	or or0(sclk[0], clk);
	or desligar1(desl[0], clk, sclk[1]);
	or desligar2(desl[1], clk, sclk[1]);
	
	
	//defini as 12 posições para o numero 99 em BCD
	wire [0:11] noventaenove;
	or or994(noventaenove[0], ch);
	or or997(noventaenove[3], ch);
	or or998(noventaenove[4], ch);
	or or9911(noventaenove[7], ch);
	//fio para saida do circuito do botão
	wire[0:6] pontos;
	wire invs;
	not notsinal(invs, sinal);
	wire [0:11] comp; 
	
	
	// Valor do botão clicado é definido
	pontuar(btn, pontos[0], pontos[1]);
	//operação é realizada entre o valor inserido pela chave e o do botão. 
	//(Soma para nivel logico baixo e subtração para nivel logico alto)
	// Mantenha o botão precionado e as chaves para cima 
	// valores de entrada e de saida são dados na ordem inversa. (Baixo para cima, direita pra esquerda)
	somador_subtrator_complemto7b(invs, chave, pontos,  cin, s, cout);
	//converte o valor binario em bcd. Entrada é dada na ordem inversa por causa da saida do somador
	// saida na ordem normal
	binario_bcd(s[6], s[5], s[4], s[3], s[2], s[1], s[0], T[0], T[1], T[2], T[3], T[4], T[5], T[6], T[7], T[8], T[9], T[10], T[11]);
	// compara se A>B e retorna nivel logico alto
	
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
	comparador_bcd_24_bits(comp,noventaenove, alerta);
	// entradas e saidas das casas de unidade e dezena do bcd que são convertidas para saidas em 7 segmentos
	bcd7segs (T[4], T[5], T[6], T[7], set[6], set[5], set[4], set[3], set[2], set[1], set[0]);
	bcd7segs (T[8], T[9], T[10], T[11], set[13], set[12], set[11], set[10], set[9], set[8], set[7]);
	//tristates que comparam os valores dos dois decodificadores bcd e retorna uma das entradas como saida
	// Se clock tiver em 1 e clock barrado tiver em 0 a saida A tera passagem e se o clock tiver em 0 e seu barramento em 1 a saida B tera vez
	tristate(set[6], set[13], clk, saida[0]);
	tristate(set[5], set[12], clk, saida[1]);
	tristate(set[4], set[11], clk, saida[2]);
	tristate(set[3], set[10], clk, saida[3]);
	tristate(set[2], set[9], clk, saida[4]);
	tristate(set[1], set[8], clk, saida[5]);
	tristate(set[0], set[7], clk, saida[6]);
endmodule 
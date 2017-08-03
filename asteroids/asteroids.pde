/* 
Jogo Asteroids.
*/

// import processing.sound.*;

PFont fonte;
// SoundFile musica;

ArrayList asteroides;

int precisao = 1; // Precisão de acerto
int tempo; // Tempo
int velocidade = 1; // Velocidade das naves inimigas
int saude = 1; // Saúde das naves inimigas
int pontuacao; // Pontuação

float acertos; 
float tiros;

boolean tiro; 
boolean derrota;


void setup() {
 
  size(500, 500);
  
  fonte = loadFont("AgencyFB-Reg-20.vlw"); // Carregar a fonte padrão do jogo
  //musica = new SoundFile(this, "Musica.mp3");
  
  asteroides = new ArrayList();
  
  noCursor(); // Torna o cursor do mouse invisível
  
  //musica.play();
  //musica.loop();
  
}

void draw() {
 
  background(0); // Pinta o plano de fundo de preto
  
  frameRate(30); // Atualiza a tela 30 vezes por segundo
  
  if(!derrota) {
    
    mudarDificuldade();
    spawn();
    moverAsteroide();
    atk();
    exibir();
    verificarDerrota();
    
    fill(255);
    textFont(fonte, 20);
    text("Pontuação: " + pontuacao, 10, 15);
    text("Velocidade: " + velocidade, 10, 31);
    text("Saúde do inimigo: " + saude, 10, 47);
    
    if(tiros != 0) {
      
      text("Precisão: " + int(acertos) + "/" + int(tiros), 10, 63);
      
    }
    
    tempo++;
    
  }
  
  else {
   
    textFont(fonte, 40);
    text("VOCÊ PERDEU, GAME OVER!", 10, 40);
    textFont(fonte, 20);
    text("PONTUAÇÃO FINAL: " + pontuacao, 10, 70);
    
  }
  
  tiro = false;
  
}

void mousePressed() {
 
  tiro = true;
  tiros++;
  
}

class Asteroide { // Classe responsável por criar um Asteroide
 
  int x;
  int y;
  int r;
  int maxHealth;
  int health;
  
  float speed;
  
  Asteroide(int tx, int tr, float tspeed, int th) {
   
    x = tx;
    r = tr;
    speed = tspeed;
    maxHealth = th;
    health = maxHealth;
    
  }
  
  void movimentar() {
   
    y += speed;
    
  }
  
  void exibir() {
   
    fill(255);
    
    ellipse(x, y, r, r); 
    
    float hbar = health/maxHealth * 20; // Barra de saúde do asteroide
    
    println(health + "" + maxHealth);
    
    fill(255, 0, 0);
    
    textFont(fonte, 15);
    text(health, x - 2, y + 5); 
    
  }
  
}
  
  void spawn() {
   
    if(tempo == 30){
     
      tempo = 0;
      
      Asteroide ta = new Asteroide(int(random(30, 470)), int(random(20, 40)
      ), velocidade, saude);
      
      asteroides.add(ta);
      
      ta = null;
      
      precisao ++;

    }
    
  }
    
    void moverAsteroide() {
      
      for(int i = 0; i < asteroides.size(); i++){
       
        Asteroide ta = (Asteroide)asteroides.get(i); // Cria um novo asteroide baseado no ArrayList de asteroides na posição i
        ta.movimentar();
        
        ta = null;
        
      }  
      
  }
  
  void exibir() { // Modelagem da nave do jogador
   
    for(int i = 0; i < asteroides.size(); i++){
     
      Asteroide ta = (Asteroide)asteroides.get(i);
      ta.exibir();
      
      ta = null;
      
    }
    
    fill(0, 0, 255);
    
    rect(mouseX - 20, 480, 40, 500);
    rect(mouseX - 10, 470, 20, 480);
    
    if(tiro) { // Se a variável tiro for verdadeira (botão do mouse for pressionado), então desenhará o tiro
     
      stroke(0, 255, 0);
      
      line(mouseX, 0, mouseX, 500);
      
      stroke(0);
      
    }
    
  }
  
  void atk() { // Método que controla a destruição dos asteroides inimigos
   
    if(tiro) {
     
      for(int i = 0; i < asteroides.size(); i++){
       
        Asteroide ta = (Asteroide) asteroides.get(i);
        
        if(mouseX < ta.x + ta.r && mouseX > ta.x - ta.r){
        
          ta.health -= 1;
          
          if(ta.health <= 0) {
          
            ta = null;
            
            asteroides.remove(i);
            
            pontuacao += int(velocidade) + saude;
            
          }
          
          acertos ++;
          pontuacao ++;
          
        }
        
      }
      
    }
    
  }
  
  void verificarDerrota() { // Ocorrerá a derrota se o eixo y do asteroide for maior do que o eixo y da tela
   
    for(int i = 0; i < asteroides.size(); i++){
     
      Asteroide ta = (Asteroide)asteroides.get(i);
      
      if(ta.y > 500) { 
        
        derrota = true;
        
      }
      
    }
    
  }
  
  void mudarDificuldade() {
   
    if(velocidade < 8 && precisao >= 10) {
     
      velocidade = precisao / 10;
      
    }
    
    if(saude < 3 && precisao >= 10) {
     
      saude = int(precisao / 10);
      
    }
    
  }
  

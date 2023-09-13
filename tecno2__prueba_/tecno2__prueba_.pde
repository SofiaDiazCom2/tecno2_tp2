import fisica.*;

//import netP5.*;
//import oscP5.*;

FWorld mundo;

//OscP5 osc;


//CAÑÓN

Lanzamiento l;

//BARRA DE DECONSTRUCCIÓN

int anchoBarra = 200;

float barraX = width*7+50 - anchoBarra;
float barraY = 30; // Ajusta la posición vertical de la barra
float barraAltura = 30; // Ajusta la altura de la barra


//CODIGO JULI

//float amortiguacion = 0.9;
//float umbralDistancia = 50;

//PVector indice;
//PVector pulgar;

//PVector puntero;

//boolean seTocan = false;
//boolean antesSeTocaban = false;

//boolean down = false;
//boolean up = false;

//float posX, posY;
//float initPosX = 0;


int estado = 0;

PImage inicio;

//Rana
int maxImage = 5;
int imageIndex = 0;
PImage [] rana = new PImage[maxImage];
int velocidadRana = 8;

void setup() {

  size(800, 600);
  background(255);


  inicio = loadImage("inicio.png");

  Fisica.init ( this );
  mundo = new FWorld();
  
  //osc = new OscP5(this, 8008);
  
  //indice = new PVector(0, 0);
  //pulgar = new PVector(width, height);
  //puntero = new PVector(0, 0);



  l = new Lanzamiento(120, height - 60);
  
  //Asignar las imagenes del sprite de la rana al arreglo
  for(int i = 0; i < rana.length; i++){
   rana[i] = loadImage("rana" + i + ".png");

  }
  
 agregarEnemigo();

  
}

void draw() {
  background(255);
  mundo.step(); // avanza la simulación del mundo de 1/60 de segundo  
  mundo.draw();
  // mundo.drawDebug();

  //ESTADO INICIO 

  if ( estado == 0) {

    image ( inicio, 0, 0, 800, 600);
  }


  //ESTADO JUGANDO 

  if ( estado == 1 ) {
    
  l.teclado();
  l.dibujar();
  
  borrarBalas();


  fill(0); // Color de la barra
  rect(barraX, barraY, anchoBarra, barraAltura);
  noFill();
  
  //codigo Juli
  
  // down = !antesSeTocaban && seTocan;
  //up = antesSeTocaban && !seTocan;

  //if (down) println("DOWN");
  //if (up) println("UP");
  
  //puntero.x =  lerp(pulgar.x, indice.x , 0.5);
  //puntero.y =  lerp(pulgar.y, indice.y , 0.5);
  
  //Codigo Dii
  
  //Dibujar la rana
  image(rana[imageIndex], width / 2 + 250, height / 2 + 100);
  
  if (frameCount % velocidadRana == 0) {
    imageIndex = (imageIndex + 1) % rana.length;
  }
  }

  //ESTADO GANAR

  if (estado == 3) {

    background(0, 255, 0);
    push();
    fill(255);
    textSize(50);
    text("GANASTE", 300, height/2);
    pop();

    push();
    textSize(30);
    text("Lograste deconstruir al pastor", 195, height/2+60);
    pop();
  }

  //ESTADO PERDER

  if ( estado == 4) {
    background(255, 0, 0);
    fill(255);
    textSize(50);
    text("PERDISTE", 300, height/2);
  }

}


void keyPressed() { 

  if (key == ENTER ) { 

    estado++;
  }
  
  // void oscEvent(OscMessage m) {

  ////println(m);

  //if (m.addrPattern().equals("/annotations/thumb")) {
  //  pulgar.x = map( m.get(9).floatValue(), 0, 800, width, 0 );
  //  pulgar.y = map( m.get(10).floatValue(), 0, 600, 0, height );
  //}
  //if (m.addrPattern().equals("/annotations/indexFinger")) {
  //  indice.x = map( m.get(9).floatValue(), 0, 800, width, 0 );
  //  indice.y = map( m.get(10).floatValue(), 0, 600, 0, height );
  //}
  
  //if (m.addrPattern().equals("/annotations/palmBase")) {
  //  posX = map( m.get(0).floatValue(), 0, 800, width, 0 );
  //  posY = map( m.get(1).floatValue(), 0, 600, 0, height );
  //}
 
  
  
  
}

//Video explicativo ==> https://youtu.be/bgyjXOfgeVA?si=A3ZjL15LaAwCUzmh

import netP5.*;
import oscP5.*;
import fisica.*;
import processing.sound.*;

// Declaración de objetos
Biblia b;
FWorld mundo;
FCircle pelota;
OscP5 osc;
SoundFile miSonido;
SoundFile miSonido2;
SoundFile principio;
SoundFile comienzo;
SoundFile Ganaste;
SoundFile Perdiste;

FBox fondoJ; // Fondo del juego
Lanzamiento l; // Objeto de lanzamiento
FBox barra; // Barra de deconstrucción
int anchoBarra = 0; // Ancho inicial de la barra
float barraX = 500;
float barraY = 50; // Ajusta la posición vertical de la barra
float barraAltura = 40; // Ajusta la altura de la barra
float angulo; // Dirección de lanzamiento
float fuerza; // Impulso del lanzamiento
float angulo_m;
float fuerza_m;

float amortiguacion = 0.9;
float umbralDistancia = 50;
PVector indice;
PVector pulgar;
PVector puntero;
boolean seTocan = false;
boolean antesSeTocaban = false;
boolean down = false;
boolean up = false;
boolean seDisparo=false;
boolean palmaDetectada = false;
int tiempoPalmaDetectada = 0; // Guarda el tiempo en que se detectó la palma
int tiempoEspera = 3000; // 5000 milisegundos = 5 segundos
int tiempoMostrarPalma = 3000;
boolean dedosTocandose = false;
int tiempoInicioToqueDedos = 0;
boolean seTocanAnterior = false;
boolean dedosPresionados = false;

boolean sonidoEnReproduccion = false;
boolean comienzoEnReproduccion = false;
float posX, posY;
float initPosX = 0;
int estado = 0;

PImage inicio;
PImage contador;
PImage fondo;
PImage strokeBarra;
PImage relleno;
PImage chanchito;
PImage oveja;
PImage brazo;
PImage corazon;

PFont fuente;
boolean lock = false; // Como una especie de diagrama de estados con 1 estado
int maxImage = 4;
int maxImage2 = 2;
int maxImage3 = 12;
int imageIndex = 0;
int imageIndex2 = 0;
int imageIndex3 = 0;
PImage[] fondoGanar = new PImage[maxImage];
PImage[] fondoPerder = new PImage[maxImage2];
PImage[] pastor = new PImage[maxImage3];
int velocidadBandera = 8;
int velocidadAgua = 30;
int velocidadHablar = 20;
boolean gameOver = false;
boolean ganaste = false;

//------------------------SETUP----------------------

void setup() {
  size(800, 600);
  // Carga de imágenes, fuentes y sonidos
  Fisica.init(this);
  mundo = new FWorld();

  inicio = loadImage("inicio2.png");
  contador = loadImage("contador.png");
  strokeBarra = loadImage("stroke.png");
  relleno = loadImage("relleno.png");
  fondo = loadImage("fondo.png");
  chanchito = loadImage("chanchito.png");
  oveja = loadImage("oveja.png");
  brazo = loadImage("brazo.png");
  corazon = loadImage("corazon.png");
  fuente = createFont("fuente.ttf", 18);

  comienzo = new SoundFile(this, "comienzo.mp3");
  principio = new SoundFile(this, "dont-go-breaking-my-heart-instrumental.mp3");
  comienzo.amp(0.03);
  principio.amp(0.4);

  principio.play();
  principio.loop();

  textFont(fuente);
  fondoJ = new FBox(800, 600);

  miSonido = new SoundFile(this, "sonido-de-lanzar-algo.mp3");
  miSonido2 = new SoundFile(this, "perros-ladrar-quejidos.mp3");
  miSonido2.amp(0.08);

  Ganaste= new SoundFile(this, "y-m-c-a-instrumental.mp3");
  Perdiste= new SoundFile(this, "ave-maria-schubert-alice-van-noppen.mp3");

  l = new Lanzamiento(120, 370, contadorDeColisiones);
  b = new Biblia();

  for (int i = 0; i < fondoGanar.length; i++) {
    fondoGanar[i] = loadImage("fondoGanar" + i + ".png");
  }

  for (int i = 0; i < fondoPerder.length; i++) {
    fondoPerder[i] = loadImage("fondoPerder" + i + ".png");
  }

  for (int i = 0; i < pastor.length; i++) {
    pastor[i] = loadImage("pastor" + i + ".png");
  }

  agregarEnemigo();
  osc = new OscP5(this, 8008);
  indice = new PVector(0, 0);
  pulgar = new PVector(width, height);
  puntero = new PVector(0, 0);
}

//------------------------DRAW----------------------

void draw() {

  //ESTADO 1 JUGANDO----------------------------------------------------------------------
  //REPETIDO PARA QUE SE DIBUJE EL FONDO PRIMERO
  if ( estado == 1 ) {
    image ( fondo, 0, 0, 800, 600);

    image(pastor[imageIndex3], width/2+150, height/2-100, 228, 278);

    if (frameCount % velocidadHablar == 0) {
      imageIndex3 = (imageIndex3 + 1) % pastor.length;
    }
  }

  mundo.step(); // Avanza la simulación del mundo de 1/60 de segundo  
  mundo.draw();

  println(estado);

  //ESTADO 0 INICIO----------------------------------------------------------------------
  if ( estado == 0) {
    image ( inicio, 0, 0, 800, 600);

    if (dedosTocandose && tiempoInicioToqueDedos != 0) {
      int tiempoActual = millis();
      if (tiempoActual - tiempoInicioToqueDedos >= 3000) { // 3 segundos en milisegundos
        estado = 1; // Transición al "estado 1"
        dedosPresionados = true; 
        tiempoInicioToqueDedos = 0; // Reiniciar el tiempo de inicio
      }
    } else {
      tiempoInicioToqueDedos = 0; // Reiniciar el tiempo si los dedos se sueltan
    }

    if (estado ==1) {
      principio.stop();
      comienzo.play();
      comienzo.loop();
    }
  }

  //ESTADO 1 JUGANDO----------------------------------------------------------------------
  if ( estado == 1 ) {
    palmaDetectada = false;
    l.dibujar();
    borrarBalas();


    textSize(15);
    image(strokeBarra, barraX, barraY, 202, 42);

    pushStyle();
    fill(0);
    tint( 255, 170);
    image(relleno, barraX, barraY, anchoBarra, 42);
    text("DECONSTRUCCIÓN", 527, 77);
    popStyle();

    image (chanchito, 68, 315, 100, 140);



    b.dibujar();

    down = !antesSeTocaban && seTocan;
    up = antesSeTocaban && !seTocan;
    antesSeTocaban = seTocan;

    if (down) println("DOWN");
    if (up) println("UP");

    puntero.x =  lerp(pulgar.x, indice.x, 0.5);
    puntero.y =  lerp(pulgar.y, indice.y, 0.5);

    seTocan = dist(pulgar.x, pulgar.y, indice.x, indice.y) < umbralDistancia;

    println(dist(pulgar.x, pulgar.y, indice.x, indice.y) );

    if ( down ) {
      miSonido.play();
      miSonido.amp(0.4);
      l.disparar(mundo);
    }

    if (anchoBarra == 202) {
      ganaste = true;
    }

    if (ganaste == true) {
      estado = 2;
    }

    if (estado ==2) {
      Ganaste.play();
      Ganaste.amp(0.4);
    }

    if (estado !=2) {
      Ganaste.stop();
    }

    if (estado ==3) {
      Perdiste.play();
      Perdiste.amp(0.4);
    }
    if (estado !=3) {
      Perdiste.stop();
    }
  }

  //ESTADO 2 GANAR----------------------------------------------------------------------
  if (estado == 2 && !gameOver) {
    comienzo.stop();

    image(fondoGanar[imageIndex], 0, 0);

    if (frameCount % velocidadBandera == 0) {
      imageIndex = (imageIndex + 1) % fondoGanar.length;
    }
  }

  //ESTADO 3 PERDER ----------------------------------------------------------------------
  if (estado == 3 && !gameOver ) {
    comienzo.stop();
    image(fondoPerder[imageIndex2], 0, 0);

    if (frameCount % velocidadAgua == 0) {
      imageIndex2 = (imageIndex2 + 1) % fondoPerder.length;
    }
  }

  borrarBalas();
}

//------------------------REINICIO----------------------
void reiniciar() { 
  estado = 0;
  anchoBarra = 0;
  l.reiniciar();
  principio.play();
  principio.loop();
  Ganaste.stop();
  Perdiste.stop();
  ganaste = false;
  contadorDeColisiones = 0;
  palmaDetectada = false;
  tiempoPalmaDetectada = 0;
  agregarEnemigo();
}

//------------------------HANDPOSE----------------------
void oscEvent(OscMessage m) {
  if (m.addrPattern().equals("/annotations/thumb")) {
    pulgar.x = map( m.get(9).floatValue(), 0, 800, width, 0 );
    pulgar.y = map( m.get(10).floatValue(), 0, 600, 0, height );

    if (!palmaDetectada) {
      palmaDetectada = true;
      tiempoPalmaDetectada = millis();
    } else {
      if (millis() - tiempoPalmaDetectada >= tiempoEspera ) {
        if (estado==2 || estado==3) {
          estado=0;
          reiniciar();
          palmaDetectada = false;
        }
      }
    }
  }
  if (m.addrPattern().equals("/annotations/indexFinger")) {
    indice.x = map( m.get(9).floatValue(), 0, 800, width, 0 );
    indice.y = map( m.get(10).floatValue(), 0, 600, 0, height );

    float distanciaDedos = dist(indice.x, indice.y, pulgar.x, pulgar.y);
    if (distanciaDedos < umbralDistancia) {
      dedosTocandose = true;
      if (tiempoInicioToqueDedos == 0) {
        tiempoInicioToqueDedos = millis();
      }
    } else {
      dedosTocandose = false;
      tiempoInicioToqueDedos = 0;
    }
  }
  if (m.addrPattern().equals("/annotations/palmBase")) {
    posX = map( m.get(0).floatValue(), 0, 800, width, 0 );
    posY = map( m.get(1).floatValue(), 0, 600, 0, height );
  }
}

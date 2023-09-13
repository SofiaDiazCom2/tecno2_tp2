import fisica.*;

FWorld mundo;
FCircle pelota;

//CAÑÓN

Lanzamiento l;

//BARRA DE DECONSTRUCCIÓN

FBox barra;
int anchoBarra = 200;

float barraX = width*7+50 - anchoBarra;
float barraY = 30; // Ajusta la posición vertical de la barra
float barraAltura = 30; // Ajusta la altura de la barra

float angulo; //dirección de lanzamiento
float fuerza; //impulso del lanzamiento

float angulo_m;
float fuerza_m;

boolean lock = false; //como una especie de diagrama de estados con 1 estado
int estado = 0;

PImage inicio;

void setup() {

  size(800, 600);

  inicio = loadImage("inicio.png");

  Fisica.init ( this );
  mundo = new FWorld();

  //mundo.setEdges(); // setea bordes negros, de dimensiones determinadas, al mundo

  //pelota = crearEsfera( 50, height - 50, 40, color(255, 0, 0));
  //pelota.setName("pelota");
  //mundo.add(pelota);

  agregarEnemigo();


  l = new Lanzamiento(120, height - 60);
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

    //if ( lock ) { //if (manoX--) --> cuanto más a la izquierda esta posicionada la mano, más fuerza toma la pelota

    //  fuerza_m++;

    //  if ( fuerza_m >= 50) { //if(manoX == pelota.getX()) --> si la mano está en el centro de la pelota, la fuerza vuelve a 0

    //    fuerza_m = 0;
    //  }

    //  float lx = pelota.getX() + 40 * cos(angulo);
    //  float ly = pelota.getY() + 40 * sin(angulo);

    //  line( pelota.getX(), pelota.getY(), lx, ly);
    //  ellipse( pelota.getX(), pelota.getY(), 40 + fuerza_m, 40 + fuerza_m); //ASI SE VISUALIZA LA FUERZA/EL IMPULSO
    //} else { //primer estado => lock == false por lo que, primero se define el ángulo y después el impulso

    //  //IMPORTANTE: establecer un rango de 90 a 180 grados, si está en el medio se produce un angulo de 135 grados
    //  // OTRA COSA IMPORTANTE es que no se deberia aumentar el angulo automaticamente sino que tieneque estar conectada directamente con la posicion de la no en el eje Y (manoY)
    //  angulo_m += 0.01; //if(manoY--) --> cuanto más arriba está la mano, menor es el angulo ( más cerca del 90 que del 180) y viceversa

    //}
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
}

//if(lock){

//  //print(fuerza_m);
//  fuerza = fuerza_m;
//  fuerza_m = 0;
//  print("VALOR:" + fuerza);

// float x = cos(angulo) * fuerza * 500;
// float y = sin(angulo) * fuerza * 500;
// pelota.addImpulse( x, y );
// lock = false;
//}




//ADDIMPULSE ==> FUERZA

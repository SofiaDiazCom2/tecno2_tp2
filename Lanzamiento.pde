class Lanzamiento {
  float x, y;
  float angulo;
  float nx;
  float ny;
  float largo = 70;
  float ancho = 30;
  float diam = 20; // Diámetro de la pelota
  float velocidad = 1000; // Velocidad del disparo
  float fuerza = 0;


  float velocidadesX [];
  float velocidadesY [];

  float[] pesos;

  int cant = 15;
  float amortiguacion = 0.9;
  PImage fondo = loadImage("fondo.png");
  int balasCreadas = 0;
  float vel = 2;
  float tiempoUltimoDisparo = 0;
  float tiempoEntreDisparos = 1000;
  int contadorDeColisiones;
  boolean perdiste = false;

  Lanzamiento(float x_, float y_, int contador) {
    x = x_;
    y = y_;

    velocidadesX = new float [cant];
    velocidadesY = new float [cant];

    for ( int i = 0; i < cant; i++) {
      velocidadesX[i] = velocidad * cos(angulo); 
      velocidadesY[i] = velocidad * sin(angulo);
    }

    pesos = new float[cant];
    for (int i = 0; i < cant; i++) {
      pesos[i] = random(0.8, 2.0); // Puedes ajustar los valores de peso según tus necesidades
    }

    angulo = radians(-90);
    contadorDeColisiones = contador;
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    rotate(angulo);

    angulo = map(posX, 0, width, radians(0), radians(posY));
    float nuevoAngulo = atan2(radians(-360), radians(posY));
    angulo = lerp(angulo, nuevoAngulo, 0.9);
    image(brazo, 0, 0, 65, 40);
    popMatrix();
    
    image ( contador, 50, 40, 180, 38);
    textSize(14);
    fill(255);
    text(balasCreadas + " / 15 ", 160, 63);

   if (fuerza <=3) {
      fuerza+= 0.05;
    } else if (fuerza>=3) {
      fuerza=0;
    }
    image(fuerzabarra, 30, 290,30, 120);
    image(brazofuerte,10,250,70,60);
    strokeWeight(20);
    stroke(161, 41,77);
    line ( 40, 400-fuerza*25, 49, 400-fuerza*25);
    println("fuerza = " + fuerza);
   

    if (balasCreadas >= 15 && contadorDeColisiones <= 5) {
      perdiste = true;
    }

    if (perdiste == true) {
      estado = 3;
    }
  }

  void disparar(FWorld mundo) {
    if (balasCreadas < 15) {
      FCircle bala = new FCircle(diam);
      bala.setPosition(x+40, y+10);
      bala.attachImage(corazon);
      bala.setName("bala");

      float pesoBala = pesos[balasCreadas];
      float velocidadBala = velocidad / pesoBala;
      float vx = velocidadBala * (cos(angulo) * fuerza);
      float vy = velocidadBala * (sin(angulo) * fuerza);

      bala.setVelocity(vx, vy);
      mundo.add(bala);

      balasCreadas++;
    }
  }

  void oscEvent(OscMessage m) {
    if (m.addrPattern().equals("/annotations/palmBase")) {
      posX = map(m.get(0).floatValue(), 0, 800, width, 0);
      posY = map(m.get(1).floatValue(), 0, 600, 0, height);
    }
  }
  
  
  
  void viento() {
    if (bibliaDesaparecida == true) {
      // Ajusta la velocidad de todas las balas existentes para simular el viento
      ArrayList<FBody> cuerpos = mundo.getBodies();
      for (FBody este : cuerpos) {
        String nombre = este.getName();
        if (nombre != null && nombre.equals("bala")) {
          // Ajusta la velocidad en la dirección x para simular el viento
          float vx = este.getVelocityX();
          este.setVelocity(vx - velocidadVientoX, este.getVelocityY());
        }
      }
    }
    
  }

  void reiniciar() {
    balasCreadas = 0;
    contadorDeColisiones = 0;
    perdiste = false;
  }
}

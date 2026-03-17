PImage img;

void setup() {
  img = loadImage("sample2.jpg");
  size(600,600);

  img.loadPixels();

  for (int x = 0; x < img.width; x++) {
    color[] column = new color[img.height];

    for (int y = 0; y < img.height; y++) {
      column[y] = img.pixels[y * img.width + x];
    }
    column = sort(column);

//re-write the image(Using AI)
    for (int y = 0; y < img.height; y++) {
      img.pixels[y * img.width + x] = column[y];
    }
  }

  img.updatePixels();

  image(img, 0, 0,width,height);
}
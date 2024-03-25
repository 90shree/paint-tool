<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Simple Paint</title>
<style>
  #canvas {
    border: 1px solid black;
  }
</style>
</head>
<body>

<canvas id="canvas" width="400" height="400"></canvas>
<br>
<button onclick="changeColor('black')">Black</button>
<button onclick="changeColor('red')">Red</button>
<button onclick="changeColor('green')">Green</button>
<button onclick="changeColor('blue')">Blue</button>
<button onclick="clearCanvas()">Clear</button>

<script>
  const canvas = document.getElementById('canvas');
  const ctx = canvas.getContext('2d');
  let isPainting = false;

  canvas.addEventListener('mousedown', startPainting);
  canvas.addEventListener('mouseup', stopPainting);
  canvas.addEventListener('mousemove', draw);

  function startPainting(event) {
    isPainting = true;
    draw(event);
  }

  function stopPainting() {
    isPainting = false;
  }

  function draw(event) {
    if (!isPainting) return;

    const x = event.offsetX;
    const y = event.offsetY;

    ctx.lineWidth = 5;
    ctx.lineCap = 'round';
    ctx.strokeStyle = color;
    ctx.lineTo(x, y);
    ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(x, y);
  }

  let color = 'black';

  function changeColor(newColor) {
    color = newColor;
  }

  function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
  }
</script>

</body>
</html>

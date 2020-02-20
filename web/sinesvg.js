/*
 http://www.humblesoftware.com/demos/trig_d3
 */
var
    ID_TRIG = '#sineSVG',
    X1      = 'x1',
    X2      = 'x2',
    Y1      = 'y1',
    Y2      = 'y2';

var
    data    = [],
    width   = 800,
    height  = 300,
    xmin    = -2,
    xmax    = 6,
    ymin    = -height * (xmax - xmin) / width / 2,
    ymax    = -ymin,
    xScale  = d3.scale.linear(),
    yScale  = d3.scale.linear(),
    vis     = d3.select(ID_TRIG).append('svg:svg'),
    decor   = vis.append('svg:g'),
    graph   = vis.append('svg:g'),
    circle  = graph.append('svg:circle'),
    b       = graph.append('svg:line'),
    c       = graph.append('svg:line'),
    label   = graph.append('svg:text'),
    path    = graph.append('svg:path'),
    dot     = graph.append('svg:circle'),
    dot2     = graph.append('svg:circle'),
    sine    = d3.svg.line(),
    time    = 0,
    i;

var n = 84;

for (i = 0; i < n; i++) {
    data.push(i * 10 / n);
}

xScale
    .domain([xmin, xmax])
    .range([0, width]);

yScale
    .domain([ymin, ymax])
    .range([0, height]);

vis
    .attr('class', 'trig')
    .attr('width', width)
    .attr('height', height);

sine
    .x(function (d, i) { return xScale(d); })
    .y(function (d, i) { return yScale(Math.sin(d - time)); });

// X-Axis
decor.append('svg:line')
    .attr('class', 'axis')
    .attr('stroke', 'black')
    .attr(X1, xScale(xmin))
    .attr(Y1, yScale(0))
    .attr(X2, xScale(xmax))
    .attr(Y2, yScale(0));

decor.append('svg:line')
    .attr('class', 'axis')
    .attr('stroke', 'black')
    .attr(X1, xScale(Math.PI))
    .attr(Y1, yScale(0))
    .attr(X2, xScale(Math.PI))
    .attr(Y2, yScale(0) + 8);

decor.append("svg:text")
    .text(String.fromCharCode(960))
    .attr("x", Math.round(xScale(Math.PI)))
    .attr("y", (yScale(0)) + 24)
    .attr("text-anchor", "middle");

// Y-Axis
decor.append('svg:line')
    .attr('class', 'axis')
    .attr('stroke', 'black')
    .attr(X1, xScale(0))
    .attr(Y1, yScale(ymin))
    .attr(X2, xScale(0))
    .attr(Y2, yScale(ymax));

// Time
label
    .attr("x", 2)
    .attr("y", 24);

// Circle
circle
    .attr('cx', xScale(0))
    .attr('cy', yScale(0))
    .attr('r', xScale(1) - xScale(0))
    .attr('stroke', 'red')
    .attr('stroke-width', '2')
    .style('fill', 'none');

// Dot
dot
    .attr('cx', xScale(0))
    .attr('r', 5)
    .attr('stroke', 'red')
    .attr('stroke-width', '2')
    .style('fill', '#fff');

dot2
    .attr('cx', xScale(0))
    .attr('r', 5)
    .attr('stroke', 'red')
    .attr('stroke-width', '2')
    .style('fill', '#fff');


// Triangle
c
    .attr('stroke', 'red')
    .attr('stroke-width', '2')
    .attr(X1, xScale(0))
    .attr(Y1, yScale(0));

b
    .attr('stroke-dasharray','5,5')
    .attr('stroke-width', '2')
    .attr('stroke', 'red');

path
    .attr('stroke', 'red')
    .attr('stroke-width', '2')
    .attr('fill','none');

function drawSvg() {

    var
        x = xScale(Math.cos(time)),
        y = yScale(-Math.sin(time));


    label
        .text('t = '+ Math.floor(time / Math.PI));

    c
        .attr(X2, x)
        .attr(Y2, y);

    b
        .attr(X1, xScale(0))
        .attr(Y1, y)
        .attr(X2, x)
        .attr(Y2, y);

    dot
        .attr('cy', y);

    dot2
        .attr('cy', y)
        .attr('cx', x);

    path
        .attr('d', sine(data));


    time += .005 * Math.PI;

    //setTimeout(drawSvg, 35);
}
drawSvg();

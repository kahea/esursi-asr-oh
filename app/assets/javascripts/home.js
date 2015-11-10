
function chart_amplitude(div, data, time) {

  var container = d3.select('#'+div);
  var div = div;
  var data = JSON.parse(data);
  var width = $('#'+div).width();
  var height = $('#'+div).height();
  var data_max = d3.max(data);
  var data_min = d3.min(data);
  var padding = { top: 20, right: 20, bottom: 50, left: 75 };
  var padding_x = padding.left + padding.right;
  var padding_y = padding.top + padding.bottom;
  var plot_width = width - padding_x;
  var plot_height = height - padding_y;

  xscale = d3.scale.linear()
  	.range([0, plot_width])
  	.domain([0, data.length]);

  xscale_seconds = d3.scale.linear()
    .range([0, plot_width])
    .domain([0, time]);

  yscale = d3.scale.linear()
  	.range([plot_height, 0])
  	.domain([data_min, data_max]);

  xaxis = d3.svg.axis()
  	.scale(xscale)
  	.orient('bottom')
  	.ticks(0);

  xaxis2 = d3.svg.axis()
    .scale(xscale_seconds)
    .orient('bottom');

  yaxis = d3.svg.axis()
  	.scale(yscale)
  	.orient('left');

  svg = container
    .append('svg')
      .attr({
      	width: width,
     		height: height,
     		transform: "translate(" + padding.left + "," + padding.top + ")"
     	});
    // .append('g')
      // .attr('transform', "translate(" + padding_x +  ")");

  svg.selectAll('circle')
  	.data(data)
  	.enter()
  	.append('circle')
    .style('fill', 'steelblue')
  	.attr({
  		cx: function(d, i) { return xscale(i) },
  		cy: function(d) { return (yscale(d) * 1) },
  		r: 2,
  	})

  svg.append('g')
  	.attr({
  		class: 'axis',
  		'stroke-width': 1,
  		transform: "translate(0," + ((plot_height)/2) + ")",
      ticks: 2
  	})
  	.call(xaxis);

  svg.append('g')
    .attr({
      class: 'axis',
      transform: "translate(0," + (plot_height) + ")",
      'stroke-width': 1,
    })
    .call(xaxis2);

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: "translate(" + plot_width/2 + ","  + (height - padding.bottom + 19) + ")",
      // transform: "translate(,200,200
    })
    .text('seconds');

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: 'rotate(-90)',
      x: (padding.top) - (height/2),
      y: 0 - padding.left/2 - 15,
      // transform: "translate(" + plot_width/2 + ","  + (height - padding.bottom + 19) + ")",
      // transform: "translate(,200,200
    })
    .text('amplitude');

  svg.selectAll('.tick')
  	.each(function(d) {
  		if (d === 0) { this.remove() };
  	});

  svg.append('g')
  	.attr({
  		class: 'axis',
  		'stroke-width': 1,
  	})
  	.call(yaxis);

  // for (i in data) {
  //   svg.append('line')
  //     .style('stroke', 'black')
  //     .attr({
  //       x1: xscale(i),
  //       y1: (plot_height/2),
  //       x2: xscale(i),
  //       y2: yscale(data[i]),
  //     })
  // }

}

function chart_magnitude(div, data) {

  var container = d3.select('#'+div);
  var div = div;
  var data = JSON.parse(data);
  var width = $('#'+div).width();
  var height = $('#'+div).height();
  var data_max = d3.max(data);
  var data_min = d3.min(data);
  var padding = { top: 20, right: 20, bottom: 50, left: 75 };
  var padding_x = padding.left + padding.right;
  var padding_y = padding.top + padding.bottom;
  var plot_width = width - padding_x;
  var plot_height = height - padding_y;

  xscale = d3.scale.linear()
    .range([0, plot_width])
    .domain([0, data.length]);

  yscale = d3.scale.linear()
    .range([plot_height, 0])
    .domain([data_min , data_max]);

  xaxis = d3.svg.axis()
    .scale(xscale)
    .orient('bottom')
    // .ticks(plot_width/data.length);

  yaxis = d3.svg.axis()
    .scale(yscale)
    .orient('left');

  svg = container
    .append('svg')
      .attr({
        width: width,
        height: height,
        transform: "translate(" + padding.left + "," + padding.top + ")"
      });

  svg.selectAll('circle')
    .data(data)
    .enter()
    .append('circle')
    .style('fill', 'red')
    .attr({
      cx: function(d, i) { return xscale(i) },
      cy: function(d) { return (yscale(d) * 1) },
      r: 2,
    })

  svg.append('g')
    .attr({
      class: 'axis',
      'stroke-width': 1,
      transform: "translate(0," + plot_height + ")",
      // ticks: 2
    })
    .call(xaxis);

  // svg.selectAll('.tick')
  //   .each(function(d) {
  //     if (d === 0) { this.remove() };
  //   });

  svg.append('g')
    .attr({
      class: 'axis',
      'stroke-width': 1,
    })
    .call(yaxis);

  for (i in data) {
    svg.append('line')
      .style('stroke', 'black')
      .attr({
        x1: xscale(i),
        y1: plot_height,
        x2: xscale(i),
        y2: yscale(data[i]),
      })
  }

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: "translate(" + plot_width/2 + ","  + (height - padding.bottom + 19) + ")",
      // transform: "translate(,200,200
    })
    .text('frequency');

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: 'rotate(-90)',
      x: (padding.top) - (height/2),
      y: 0 - padding.left/2 - 15,
    })
    .text('magnitude');

}

function chart_sound_pressure(div, data) {

  var div = div;
  var data = JSON.parse(data);
  var width = $('#'+div).width();
  var height = $('#'+div).height();
  var data_max = d3.max(data);
  var data_min = d3.min(data);
  var padding = { top: 0, right: 0, bottom: 0, left: 0 };
  var padding_x = padding.left + padding.right;
  var padding_y = padding.top + padding.bottom;
  var plot_width = width - padding_x;
  var plot_height = height - padding_y;

  xscale = d3.scale.linear()
    .range([0, plot_width])
    .domain([0, data.length]);

  yscale = d3.scale.linear()
    .range([plot_height, 0])
    .domain([data_min , data_max ]);

  cscale = d3.scale.linear()
    .range([255, 0])
    .domain([data_min , data_max]);

  svg = d3.select('#'+div)
    .append('svg')
      .attr({
        width: width,
        height: height,
        //transform: "translate(" + padding.left + "," + padding.top + ")"
      });

  svg.selectAll('rect')
    .data(data)
    .enter()
    .append('rect')
    .attr({
      x: function(d, i) { return  xscale(i) },
      y: function(d) { return 0 },
      width: (plot_width / data.length ),
      height: plot_height,
      fill: function(d) { return 'rgb(' + parseInt(cscale(d))  + ',' + parseInt(cscale(d)) + ',' + parseInt(cscale(d)) + ')'}
    })

}

function chart_dft_frequency(div, data, data_cos, data_cor, time) {

  var container = d3.select('#'+div);
  var div = div;

  var data = JSON.parse(data);
  var data_cos = JSON.parse(data_cos);
  var data_cor = JSON.parse(data_cor);

  var width = $('#'+div).width();
  var height = $('#'+div).height();
  var data_max = d3.max(data_cos);
  var data_min = d3.min(data_cos);
  var padding = { top: 20, right: 20, bottom: 50, left: 75 };
  var padding_x = padding.left + padding.right;
  var padding_y = padding.top + padding.bottom;
  var plot_width = width - padding_x;
  var plot_height = height - padding_y;

  xscale = d3.scale.linear()
    .range([0, plot_width])
    .domain([0, data_cos.length]);

  xscale_seconds = d3.scale.linear()
    .range([0, plot_width])
    .domain([0, time]);

  yscale = d3.scale.linear()
    .range([plot_height, 0])
    .domain([data_min, data_max]);

  xaxis = d3.svg.axis()
    .scale(xscale)
    .orient('bottom')
    .ticks(0);

  xaxis2 = d3.svg.axis()
    .scale(xscale_seconds)
    .orient('bottom');

  yaxis = d3.svg.axis()
    .scale(yscale)
    .orient('left');

  svg = container
    .append('svg')
      .attr({
        width: width,
        height: height,
        transform: "translate(" + padding.left + "," + padding.top + ")"
      });

  svg.selectAll('.dtsdata')
    .data(data)
    .enter()
    .append('circle')
    .style('fill', 'steelblue')
    .attr({
      class: 'dtsdata',
      cx: function(d, i) { return xscale(i) },
      cy: function(d) { return (yscale(d)) },
      r: 5,
    })

  svg.selectAll('.dtsdatacos')
    .data(data_cos)
    .enter()
    .append('circle')
    .style('fill', 'green')
    .attr({
      class: 'dtsdatacos',
      cx: function(d, i) { return xscale(i) },
      cy: function(d) { return (yscale(d)) },
      r: 5,
    })

  svg.selectAll('.dtsdatacor')
    .data(data_cor)
    .enter()
    .append('circle')
    .style('fill', 'red')
    .attr({
      class: 'dtsdatacor',
      cx: function(d, i) { return xscale(i) },
      cy: function(d) { return (yscale(d)) },
      r: 5,
    })

  svg.append('g')
    .attr({
      class: 'axis',
      'stroke-width': 1,
      transform: "translate(0," + ((plot_height)/2) + ")",
      ticks: 2
    })
    .call(xaxis);

  svg.append('g')
    .attr({
      class: 'axis',
      transform: "translate(0," + (plot_height) + ")",
      'stroke-width': 1,
    })
    .call(xaxis2);

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: "translate(" + plot_width/2 + ","  + (height - padding.bottom + 19) + ")",
      // transform: "translate(,200,200
    })
    .text('seconds');

  svg.append('g')
    .append('text')
    .attr({
      'text-anchor': 'middle',
      transform: 'rotate(-90)',
      x: (padding.top) - (height/2),
      y: 0 - padding.left/2 - 15,
      // transform: "translate(" + plot_width/2 + ","  + (height - padding.bottom + 19) + ")",
      // transform: "translate(,200,200
    })
    .text('amplitude');

  svg.selectAll('.tick')
    .each(function(d) {
      if (d === 0) { this.remove() };
    });

  svg.append('g')
    .attr({
      class: 'axis',
      'stroke-width': 1,
    })
    .call(yaxis);

  // for (i in data) {
  //   svg.append('line')
  //     .style('stroke', 'black')
  //     .attr({
  //       x1: xscale(i),
  //       y1: (plot_height/2),
  //       x2: xscale(i),
  //       y2: yscale(data[i]),
  //     })
  // }

}

function play(data) {

  // console.log(data);
  var data = JSON.parse(data);

  var audioCtx = new (window.AudioContext || window.webkitAudioContext)();

  var myArrayBuffer = audioCtx.createBuffer(1, data.length, audioCtx.sampleRate);

  var nowBuffering = myArrayBuffer.getChannelData(0);
  data.forEach(function(d, i) {
    nowBuffering[i] = d;
  });

  var source = audioCtx.createBufferSource();
  source.buffer = myArrayBuffer;
  source.connect(audioCtx.destination);

  // source.loop = true;
  // source.start();
}
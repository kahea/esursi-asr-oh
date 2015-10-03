
function Graph(div, data) {

  var container = d3.select('#'+div);
  var div = div;
  var data = JSON.parse(data);
  var width = $('#'+div).width();
  var height = $('#'+div).height();
  var data_max = d3.max(data);
  var data_min = d3.min(data);
  var padding = { top: 20, right: 20, bottom: 20, left: 40 };
  var padding_x = padding.left + padding.right;
  var padding_y = padding.top + padding.bottom;
  var plot_width = width - padding_x;
  var plot_height = height - padding_y;

  xscale = d3.scale.linear()
  	.range([0, plot_width])
  	.domain([0, data.length]);

  yscale = d3.scale.linear()
  	.range([0, plot_height])
  	.domain([data_min, data_max]);

  xaxis = d3.svg.axis()
  	.scale(xscale)
  	.orient('bottom');
  	// .ticks(data.length);

  yaxis = d3.svg.axis()
  	.scale(yscale)
  	.orient('left');

  // d3.select('#'+div)
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
  	.attr({
  		cx: function(d, i) { return xscale(i) },
  		cy: function(d) { return yscale(d) },
  		r: 3,
  		// fill: red
  		// fill: rgb(1,1,1)
  	})

  svg.append('g')
  	.attr({
  		// class: 'axis'
  		class: 'axis',
  		'stroke-width': 1,
  		transform: "translate(0," + (plot_height/2) + ")"
  	})
  	.call(xaxis);

  svg.selectAll('.tick')
  	.each(function(d) {
  		if (d === 0) { this.remove() };
  	});

  svg.append('g')
  	.attr({
  		class: 'axis',
  		'stroke-width': 1,
  		// transform: "translate(" + padding.left + ",20)"
  		// transform: "translate(" + padding.left + "," + padding.top + ")"
  	})
  	.call(yaxis);



}

function dts_time_amplitude_chart(div, data) {
	graph = new Graph(div, data);
	// console.log(graph);
}
            window.onload = function(){
                
                var width = 1000;
                var height = 600;
                var totalAmount = [];
                var connectedLocations=[];
                
                var svgCanvas = d3.select("#canvas")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .attr("class", "svgCanvas");
                
                var toolTip = d3.select("#canvas")
                    .append("div")
                    .attr('class','toolTip')
                    .style("position", "absolute")
                    .style("z-index", "10")
                    .style("visibility", "hidden");                
                
                d3.json("data.json", function(givenData){
                    
                    console.log(givenData);                
                
                    givenData.nodes.forEach(function(node, index){
                        totalAmount.push(0);
                        connectedLocations.push(0);
                        givenData.links.forEach(function(link){
                            if (link.node01 == node.id || link.node02 == node.id){
                                connectedLocations[index] += 1;
                                totalAmount[index] += link.amount;
                            }
                        })
                    })
                                                            
                    svgCanvas.selectAll("line").data(givenData.links)
                        .enter().append("line")
                    
				        .attr("x1",function(link){
                            nodes = givenData.nodes;
                            nodes.forEach(function(node){
                                if (link.node01 == node.id)
                                    x1 = node.x
                            }); return x1;
                        })
                        .attr("y1",function(link){
                            nodes = givenData.nodes;
                            nodes.forEach(function(node){
                                if (link.node01 == node.id)
                                    y1 = node.y; 
                                }); return y1;
                        })
                        .attr("x2",function(link){
                            nodes = givenData.nodes;
                            nodes.forEach(function(node){
                                if (link.node02 == node.id)
                                    x2 = node.x; 
                            }); return x2;
                        })
                        .attr("y2",function(link){
                            nodes = givenData.nodes;
                            nodes.forEach(function(node){
                                if (link.node02 == node.id)
                                    y2 = node.y; 
                            }); return y2;
                        })
                    
                        .attr("stroke-width",function(link){
                            return link.amount*0.012;
                        })
				        .attr("stroke","black")
                    
                    
				svgCanvas.selectAll("circle").data(givenData.nodes)
                    .enter().append("circle")
                    
                    .attr('cx', function(node){
                        return node.x;
                    })
                    .attr('cy', function(node){
                        return node.y;
                    })
                    .attr('r', function(node, index){
                        return totalAmount[index]/40;
                    })
                    
                    .attr("fill", "red")
					
                    .on("mouseover", function(node, index){	
                    
				        svgCanvas.selectAll("circle, line").attr("opacity", 0.04);
						
						d3.select(this).attr("opacity", 1);	

                        toolTip.html('Location: ' + node.id + '<br>Total Amount: ' + totalAmount[index] + '<br>Connected Nodes: ' + connectedLocations[index])
                            .style('visibility', 'visible')
                            .style("top", (event.pageY-30)+"px")
                            .style("left",(event.pageX+10)+"px");

						svgCanvas.selectAll("line")
                    
                            .attr("opacity", function(link){          
                                if (link.node01 == node.id ||  link.node02 == node.id)
                                    return 1;
                                else
                                    return 0.04;
                            })
		            })	
					
			        .on("mouseout", function(node){	
                    
						d3.selectAll("circle, line").attr("opacity", 1);
                        
                        toolTip.style("visibility", "hidden");
			        });       
            });                
        }
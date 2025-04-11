<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="en">
    <link rel="shortcut icon" href="./view/assets/img/logo_short.png">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,500;0,600;0,700;1,400&amp;display=swap">
    <link rel="stylesheet" href="./view/assets/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/fontawesome.min.css">
    <link rel="stylesheet" href="./view/assets/plugins/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="./view/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="./view/assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap-switch-button@1.1.0/css/bootstrap-switch-button.min.css" rel="stylesheet">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            #chartContainer {
                height: auto;
                width: auto;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
        </style>
        <script>

            window.onload = function () {
                var chart = new CanvasJS.Chart("chartContainer", {
                    exportEnabled: true,
                    animationEnabled: true,
                    legend: {
                        cursor: "pointer",
                        itemclick: explodePie
                    },
                    data: [{
                            type: "pie",
                            showInLegend: true,
                            toolTipContent: "{name}: <strong>{y}%</strong>",
                            indexLabel: "{name} - {y}%",
                            dataPoints: [
                                {y: ${grade *10}, name: "Right Answer", exploded: true},
                                {y: ${100 - grade*10}, name: "Wrong Answer"}
                            ]
                        }]
                });
                chart.render();
            }

            function explodePie(e) {
                if (typeof (e.dataSeries.dataPoints[e.dataPointIndex].exploded) === "undefined" || !e.dataSeries.dataPoints[e.dataPointIndex].exploded) {
                    e.dataSeries.dataPoints[e.dataPointIndex].exploded = true;
                } else {
                    e.dataSeries.dataPoints[e.dataPointIndex].exploded = false;
                }
                e.chart.render();
            }
        </script>
    </head>
    <body>
        <div class="content container-fluid">
            <div class="row d-flex justify-content-center mt-lg-4 mb-lg-4">
                <h1>Quiz Grade</h1>
            </div>
            <div class="row">
                <div class="col-lg-4">

                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered mb-0">
                                                <tbody>
                                                    <tr>
                                                        <td 
                                                            style="width: 40%"
                                                            class="font-weight-bold">
                                                            Grade
                                                        </td>
                                                        <td> ${grade}</td>
                                                    </tr>
                                                    <tr>
                                                        <td 
                                                            style="width: 40%"
                                                            class="font-weight-bold">
                                                            Attempt
                                                        </td>
                                                        <td>${g.attempt}</td>
                                                    </tr>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div id="chartContainer"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <a href="homepage" class="btn btn-primary">Return to Home</a>
                </div>
            </div>
        </div>
        <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
        <script src="./view/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="./view/assets/js/script.js"></script>
    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Información Detallada - Sample App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #667eea;
            padding-bottom: 10px;
        }
        h2 {
            color: #667eea;
            margin-top: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #667eea;
            color: white;
        }
        tr:hover {
            background: #f5f5f5;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background: #5568d3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 Información Detallada del Sistema</h1>
        
        <h2>Propiedades del Sistema</h2>
        <table>
            <thead>
                <tr>
                    <th>Propiedad</th>
                    <th>Valor</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Properties props = System.getProperties();
                    Enumeration<?> propNames = props.propertyNames();
                    List<String> sortedProps = new ArrayList<>();
                    
                    while (propNames.hasMoreElements()) {
                        sortedProps.add((String) propNames.nextElement());
                    }
                    Collections.sort(sortedProps);
                    
                    for (String propName : sortedProps) {
                        String propValue = props.getProperty(propName);
                %>
                <tr>
                    <td><strong><%= propName %></strong></td>
                    <td><%= propValue %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <h2>Variables de Entorno</h2>
        <table>
            <thead>
                <tr>
                    <th>Variable</th>
                    <th>Valor</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Map<String, String> env = System.getenv();
                    List<String> sortedEnv = new ArrayList<>(env.keySet());
                    Collections.sort(sortedEnv);
                    
                    for (String envName : sortedEnv) {
                %>
                <tr>
                    <td><strong><%= envName %></strong></td>
                    <td><%= env.get(envName) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <a href="index.jsp" class="back-link">← Volver al inicio</a>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sample Application - Práctica Docker + Tomcat</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 800px;
            width: 100%;
        }
        
        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em;
        }
        
        .success {
            background: #d4edda;
            border: 2px solid #28a745;
            color: #155724;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: center;
            font-weight: bold;
            font-size: 1.2em;
        }
        
        .info-box {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
        
        .info-box h3 {
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .label {
            font-weight: bold;
            color: #495057;
        }
        
        .value {
            color: #6c757d;
            font-family: 'Courier New', monospace;
        }
        
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #6c757d;
            font-size: 0.9em;
        }
        
        .docker-icon {
            font-size: 3em;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="docker-icon">🐳</div>
        <h1>¡Aplicación desplegada con éxito!</h1>
        
        <div class="success">
            ✅ Tu servidor Tomcat está funcionando correctamente
        </div>
        
        <div class="info-box">
            <h3>📊 Información del Sistema</h3>
            <div class="info-item">
                <span class="label">Servidor:</span>
                <span class="value"><%= application.getServerInfo() %></span>
            </div>
            <div class="info-item">
                <span class="label">Versión Java:</span>
                <span class="value"><%= System.getProperty("java.version") %></span>
            </div>
            <div class="info-item">
                <span class="label">Sistema Operativo:</span>
                <span class="value"><%= System.getProperty("os.name") %> <%= System.getProperty("os.version") %></span>
            </div>
            <div class="info-item">
                <span class="label">Fecha y Hora:</span>
                <span class="value"><%= new java.util.Date() %></span>
            </div>
            <div class="info-item">
                <span class="label">Contexto de aplicación:</span>
                <span class="value"><%= request.getContextPath() %></span>
            </div>
        </div>
        
        <div class="info-box">
            <h3>🎯 Arquitectura de la Práctica</h3>
            <div style="text-align: center; padding: 20px;">
                <p style="margin: 10px 0;">Cliente</p>
                <p style="margin: 10px 0;">⬇️</p>
                <p style="margin: 10px 0;">Nginx (Proxy Inverso - Puerto 80)</p>
                <p style="margin: 10px 0;">⬇️</p>
                <p style="margin: 10px 0;">Tomcat (Servidor de Aplicaciones - Puerto 8080)</p>
                <p style="margin: 10px 0;">⬇️</p>
                <p style="margin: 10px 0;">Aplicación WAR (Esta página)</p>
            </div>
        </div>
        
        <div class="footer">
            <p>Práctica 2.4/2.8 - Despliegue de Tomcat con Nginx</p>
            <p>Desarrollo de Aplicaciones Web - 2DAW</p>
        </div>
    </div>
</body>
</html>

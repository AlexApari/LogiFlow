<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LogiFlow - Iniciar Sesión</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .logo {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 10px;
        }

        .company-name {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }

        .input-container {
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 15px 45px 15px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .forgot-password:hover {
            color: #764ba2;
        }

        .features {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e1e5e9;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            color: #666;
            font-size: 0.9rem;
        }

        .feature-item i {
            color: #667eea;
            margin-right: 10px;
            width: 20px;
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 20px;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <i class="fas fa-truck"></i>
        </div>
        <h1 class="company-name">LogiFlow</h1>
        <p class="subtitle">Sistema de Gestión Logística</p>

        <form id="loginForm" action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Usuario:</label>
                <div class="input-container">
                    <input type="text" id="username" name="username" placeholder="Ingrese su usuario" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Contraseña:</label>
                <div class="input-container">
                    <input type="password" id="password" name="password" placeholder="Ingrese su contraseña" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
            </div>

            <button type="submit" class="login-btn">
                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
            </button>

            <a href="#" class="forgot-password">¿Olvidó su contraseña?</a>
        </form>
       
        <div class="features">
            <div class="feature-item">
                <i class="fas fa-shield-alt"></i>
				<span>Acceso seguro</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-chart-line"></i>
                <span>Reportes en tiempo real</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-mobile-alt"></i>
                <span>Acceso desde cualquier dispositivo</span>
            </div>
        </div>
    </div>
</body>
</html>
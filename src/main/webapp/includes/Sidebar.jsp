<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <nav class="sidebar">
            <a href="${pageContext.request.contextPath}/Dashboard.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Dashboard.jsp') ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
           <a href="${pageContext.request.contextPath}/Productos.jsp" 
           class="nav-item ${pageContext.request.requestURI.contains('/Productos.jsp') ? 'active' : ''}">
            <i class="fas fa-box"></i> Productos
        </a>
            <a href="${pageContext.request.contextPath}/Proveedores.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Proveedores.jsp') ? 'active' : ''}">
                <i class="fas fa-truck-loading"></i> Proveedores
            </a>
            <a href="${pageContext.request.contextPath}/Clientes.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Clientes.jsp') ? 'active' : ''}">
                <i class="fas fa-users"></i> Clientes
            </a>
            <a href="${pageContext.request.contextPath}/Pedidos.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Pedidos.jsp') ? 'active' : ''}">
                <i class="fas fa-shopping-cart"></i> Pedidos
            </a>
            <a href="${pageContext.request.contextPath}/Inventario.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Inventario.jsp') ? 'active' : ''}">
                <i class="fas fa-warehouse"></i> Inventario
            </a>
            <a href="${pageContext.request.contextPath}/Transportes.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Transportes.jsp') ? 'active' : ''}">
                <i class="fas fa-shipping-fast"></i> Transportes
            </a>
            <a href="${pageContext.request.contextPath}/Reportes.jsp" 
               class="nav-item ${pageContext.request.requestURI.contains('/Reportes.jsp') ? 'active' : ''}">
                <i class="fas fa-chart-bar"></i> Reportes
            </a>
        </nav>
<script>
// Highlight del menú activo
document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;
    const navItems = document.querySelectorAll('.nav-item');
    
    navItems.forEach(item => {
        const href = item.getAttribute('href');
        if (href && currentPath.includes(href.split('/').pop())) {
            item.classList.add('active');
        }
    });
});
</script>

import React, { useState } from 'react';
import { Home, ShoppingBag, Info, MessageCircle } from 'lucide-react';

// Componente Principal
const JiretWebsite = () => {
  const [activeSection, setActiveSection] = useState('inicio');

  const sections = {
    inicio: <InicioSection />,
    productos: <ProductosSection />,
    nosotros: <NosotrosSection />,
    contacto: <ContactoSection />
  };

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Navegación */}
      <nav className="bg-blue-600 text-white p-4 shadow-md">
        <div className="container mx-auto flex justify-between items-center">
          <div className="text-2xl font-bold">Jiret</div>
          <div className="flex space-x-6">
            {Object.keys(sections).map((section) => (
              <button 
                key={section}
                onClick={() => setActiveSection(section)}
                className={`flex items-center space-x-2 hover:text-blue-200 
                  ${activeSection === section ? 'text-white' : 'text-blue-100'}`}
              >
                {section === 'inicio' && <Home size={20} />}
                {section === 'productos' && <ShoppingBag size={20} />}
                {section === 'nosotros' && <Info size={20} />}
                {section === 'contacto' && <MessageCircle size={20} />}
                <span className="capitalize">{section}</span>
              </button>
            ))}
          </div>
        </div>
      </nav>

      {/* Contenido Dinamico */}
      <main className="flex-grow container mx-auto p-6">
        {sections[activeSection]}
      </main>

      {/* Footer */}
      <footer className="bg-blue-800 text-white py-6 text-center">
        <p>© 2024 Jiret Accesorios. Todos los derechos reservados.</p>
        <div className="mt-4 space-x-4">
          <a href="#" className="hover:text-blue-300">Política de Privacidad</a>
          <a href="#" className="hover:text-blue-300">Términos de Servicio</a>
        </div>
      </footer>
    </div>
  );
};

// Sección de Inicio
const InicioSection = () => {
  return (
    <div className="grid md:grid-cols-2 gap-8 items-center">
      <div>
        <h1 className="text-4xl font-bold text-blue-700 mb-4">Bienvenido a Jiret</h1>
        <p className="text-gray-700 mb-6">
          Somos tu tienda especializada en accesorios de alta calidad para celulares. 
          Descubre diseños únicos y protección para tu dispositivo.
        </p>
        <button className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
          Ver Productos
        </button>
      </div>
      <div>
        <img 
          src="/api/placeholder/600/400" 
          alt="Accesorios Jiret" 
          className="rounded-lg shadow-lg"
        />
      </div>
    </div>
  );
};

// Sección de Productos
const ProductosSection = () => {
  const productos = [
    { nombre: 'Funda Antigolpes', precio: 29.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Vidrio Templado', precio: 19.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Cargador Rápido', precio: 39.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Soporte de Auto', precio: 24.99, imagen: '/api/placeholder/300/300' }
  ];

  return (
    <div>
      <h2 className="text-3xl font-bold text-blue-700 mb-8 text-center">Nuestros Productos</h2>
      <div className="grid md:grid-cols-4 gap-6">
        {productos.map((producto, index) => (
          <div key={index} className="bg-white rounded-lg shadow-md p-4 text-center">
            <img 
              src={producto.imagen} 
              alt={producto.nombre} 
              className="mx-auto mb-4 rounded-lg"
            />
            <h3 className="font-semibold text-gray-800">{producto.nombre}</h3>
            <p className="text-blue-600 font-bold">${producto.precio}</p>
            <button className="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
              Comprar
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

// Sección Nosotros
const NosotrosSection = () => {
  return (
    <div className="grid md:grid-cols-2 gap-8 items-center">
      <div>
        <h2 className="text-3xl font-bold text-blue-700 mb-4">Nuestra Historia</h2>
        <p className="text-gray-700 mb-4">
          Jiret nació en 2020 con la misión de ofrecer los mejores accesorios para dispositivos móviles. 
          Nos dedicamos a brindar soluciones innovadoras y de alta calidad para proteger y personalizar 
          tu smartphone.
        </p>
        <ul className="space-y-2 text-gray-700">
          <li>✓ Más de 1000 clientes satisfechos</li>
          <li>✓ Envíos a todo el país</li>
          <li>✓ Garantía en todos nuestros productos</li>
        </ul>
      </div>
      <div>
        <img 
          src="/api/placeholder/600/400" 
          alt="Equipo Jiret" 
          className="rounded-lg shadow-lg"
        />
      </div>
    </div>
  );
};

// Sección de Contacto
const ContactoSection = () => {
  return (
    <div className="max-w-md mx-auto bg-white shadow-md rounded-lg p-8">
      <h2 className="text-3xl font-bold text-blue-700 mb-6 text-center">Contáctanos</h2>
      <form>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Nombre</label>
          <input 
            type="text" 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            placeholder="Tu nombre"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Correo Electrónico</label>
          <input 
            type="email" 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            placeholder="tu@email.com"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Mensaje</label>
          <textarea 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            rows="4"
            placeholder="Escribe tu mensaje"
          ></textarea>
        </div>
        <button 
          type="submit"
          className="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700"
        >
          Enviar Mensaje
        </button>
      </form>
    </div>
  );
};

export default JiretWebsite;import React, { useState } from 'react';
import { Home, ShoppingBag, Info, MessageCircle } from 'lucide-react';

// Componente Principal
const JiretWebsite = () => {
  const [activeSection, setActiveSection] = useState('inicio');

  const sections = {
    inicio: <InicioSection />,
    productos: <ProductosSection />,
    nosotros: <NosotrosSection />,
    contacto: <ContactoSection />
  };

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      {/* Navegación */}
      <nav className="bg-blue-600 text-white p-4 shadow-md">
        <div className="container mx-auto flex justify-between items-center">
          <div className="text-2xl font-bold">Jiret</div>
          <div className="flex space-x-6">
            {Object.keys(sections).map((section) => (
              <button 
                key={section}
                onClick={() => setActiveSection(section)}
                className={`flex items-center space-x-2 hover:text-blue-200 
                  ${activeSection === section ? 'text-white' : 'text-blue-100'}`}
              >
                {section === 'inicio' && <Home size={20} />}
                {section === 'productos' && <ShoppingBag size={20} />}
                {section === 'nosotros' && <Info size={20} />}
                {section === 'contacto' && <MessageCircle size={20} />}
                <span className="capitalize">{section}</span>
              </button>
            ))}
          </div>
        </div>
      </nav>

      {/* Contenido Dinamico */}
      <main className="flex-grow container mx-auto p-6">
        {sections[activeSection]}
      </main>

      {/* Footer */}
      <footer className="bg-blue-800 text-white py-6 text-center">
        <p>© 2024 Jiret Accesorios. Todos los derechos reservados.</p>
        <div className="mt-4 space-x-4">
          <a href="#" className="hover:text-blue-300">Política de Privacidad</a>
          <a href="#" className="hover:text-blue-300">Términos de Servicio</a>
        </div>
      </footer>
    </div>
  );
};

// Sección de Inicio
const InicioSection = () => {
  return (
    <div className="grid md:grid-cols-2 gap-8 items-center">
      <div>
        <h1 className="text-4xl font-bold text-blue-700 mb-4">Bienvenido a Jiret</h1>
        <p className="text-gray-700 mb-6">
          Somos tu tienda especializada en accesorios de alta calidad para celulares. 
          Descubre diseños únicos y protección para tu dispositivo.
        </p>
        <button className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
          Ver Productos
        </button>
      </div>
      <div>
        <img 
          src="/api/placeholder/600/400" 
          alt="Accesorios Jiret" 
          className="rounded-lg shadow-lg"
        />
      </div>
    </div>
  );
};

// Sección de Productos
const ProductosSection = () => {
  const productos = [
    { nombre: 'Funda Antigolpes', precio: 29.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Vidrio Templado', precio: 19.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Cargador Rápido', precio: 39.99, imagen: '/api/placeholder/300/300' },
    { nombre: 'Soporte de Auto', precio: 24.99, imagen: '/api/placeholder/300/300' }
  ];

  return (
    <div>
      <h2 className="text-3xl font-bold text-blue-700 mb-8 text-center">Nuestros Productos</h2>
      <div className="grid md:grid-cols-4 gap-6">
        {productos.map((producto, index) => (
          <div key={index} className="bg-white rounded-lg shadow-md p-4 text-center">
            <img 
              src={producto.imagen} 
              alt={producto.nombre} 
              className="mx-auto mb-4 rounded-lg"
            />
            <h3 className="font-semibold text-gray-800">{producto.nombre}</h3>
            <p className="text-blue-600 font-bold">${producto.precio}</p>
            <button className="mt-4 bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
              Comprar
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

// Sección Nosotros
const NosotrosSection = () => {
  return (
    <div className="grid md:grid-cols-2 gap-8 items-center">
      <div>
        <h2 className="text-3xl font-bold text-blue-700 mb-4">Nuestra Historia</h2>
        <p className="text-gray-700 mb-4">
          Jiret nació en 2020 con la misión de ofrecer los mejores accesorios para dispositivos móviles. 
          Nos dedicamos a brindar soluciones innovadoras y de alta calidad para proteger y personalizar 
          tu smartphone.
        </p>
        <ul className="space-y-2 text-gray-700">
          <li>✓ Más de 1000 clientes satisfechos</li>
          <li>✓ Envíos a todo el país</li>
          <li>✓ Garantía en todos nuestros productos</li>
        </ul>
      </div>
      <div>
        <img 
          src="/api/placeholder/600/400" 
          alt="Equipo Jiret" 
          className="rounded-lg shadow-lg"
        />
      </div>
    </div>
  );
};

// Sección de Contacto
const ContactoSection = () => {
  return (
    <div className="max-w-md mx-auto bg-white shadow-md rounded-lg p-8">
      <h2 className="text-3xl font-bold text-blue-700 mb-6 text-center">Contáctanos</h2>
      <form>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Nombre</label>
          <input 
            type="text" 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            placeholder="Tu nombre"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Correo Electrónico</label>
          <input 
            type="email" 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            placeholder="tu@email.com"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2">Mensaje</label>
          <textarea 
            className="w-full px-3 py-2 border rounded-lg focus:outline-blue-500"
            rows="4"
            placeholder="Escribe tu mensaje"
          ></textarea>
        </div>
        <button 
          type="submit"
          className="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700"
        >
          Enviar Mensaje
        </button>
      </form>
    </div>
  );
};

export default JiretWebsite;

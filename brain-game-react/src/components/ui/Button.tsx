// Game button component with animations
import { motion } from 'framer-motion';
import { useSound } from '../../hooks/useSound';

interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  variant?: 'primary' | 'secondary' | 'menu';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
  className?: string;
}

export function Button({ 
  children, 
  onClick, 
  variant = 'primary',
  size = 'medium',
  disabled = false,
  className = ''
}: ButtonProps) {
  const { play } = useSound();

  const handleClick = () => {
    if (disabled) return;
    play('buttonMenu');
    onClick?.();
  };

  const baseClasses = 'font-bold rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2';
  
  const variantClasses = {
    primary: 'bg-gradient-to-b from-green-400 to-green-600 text-white hover:from-green-500 hover:to-green-700 focus:ring-green-500',
    secondary: 'bg-gradient-to-b from-blue-400 to-blue-600 text-white hover:from-blue-500 hover:to-blue-700 focus:ring-blue-500',
    menu: 'bg-gradient-to-b from-yellow-400 to-orange-500 text-white hover:from-yellow-500 hover:to-orange-600 focus:ring-orange-500',
  };
  
  const sizeClasses = {
    small: 'px-4 py-2 text-sm',
    medium: 'px-6 py-3 text-lg',
    large: 'px-8 py-4 text-xl',
  };
  
  const disabledClasses = disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer';

  return (
    <motion.button
      className={`${baseClasses} ${variantClasses[variant]} ${sizeClasses[size]} ${disabledClasses} ${className}`}
      onClick={handleClick}
      disabled={disabled}
      whileHover={disabled ? {} : { scale: 1.05 }}
      whileTap={disabled ? {} : { scale: 0.95 }}
    >
      {children}
    </motion.button>
  );
}

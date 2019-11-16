import React from 'react';
import { TouchableOpacity, Text } from 'react-native';
import styled from 'styled-components';
import { colors } from './variables';

const buttonMap = {
  primary: `
    background-color: ${colors.purple};
    color: ${colors.white};
  `,
  secondary: `
    background-color: ${colors.snow};
    color: ${colors.darkGray};
  `,
};

const ButtonContainer = styled(TouchableOpacity)`
  ${({ variant }) => buttonMap[variant || 'primary']};
  border: none;
  border-radius: 4px;
  padding: ${({ large }) => (large ? '12px 16px 12px 16px' : '8px 12px 8px 12px')};
`;

const ButtonText = styled(Text)`
  ${({ variant }) => buttonMap[variant || 'primary']};
  font-size: ${({ large }) => (large ? '20px' : '16px')};
  font-weight: 500;
  text-align: center;
`;

export default ({ variant, large, children, ...props }) => (
  <ButtonContainer variant={variant} large={large} {...props}>
    <ButtonText variant={variant} large={large}>
      {children}
    </ButtonText>
  </ButtonContainer>
);

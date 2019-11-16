import styled from 'styled-components';
import { View } from 'react-native';

export const Flex = styled(View)`
  align-items: ${({ center }) => (center ? 'center' : 'flex-start')};
  display: flex;
  flex-direction: ${({ column }) => (column ? 'column' : 'row')};
  flex-wrap: ${({ wrap }) => (wrap ? 'wrap' : 'nowrap')};
  justify-content: ${({ horizontalCenter }) => (horizontalCenter ? 'center' : 'flex-start')};
`;

export const BaseFlex = styled(View)`
  flex: 1;
`;

export const Grow = styled(View)`
  flex-grow: 1;
`;

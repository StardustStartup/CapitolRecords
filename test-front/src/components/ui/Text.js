import { Text as T } from 'react-native';
import styled from 'styled-components';

import { colors } from './variables';

const headingMap = {
  1: `
    font-size: 36px;
    letter-spacing: -1.8px;
    line-height: 43.2px;
  `,
  2: `
    font-size: 24px;
    letter-spacing: -1.2px;
    line-height: 28.8px;
  `,
};

export const Heading = styled(T)`
  ${({ level = 1 }) => headingMap[level]};
  color: ${colors.black};
  font-weight: 700;
`;

const textMap = {
  1: `
    font-size: 20px;
    line-height: 30px;
  `,
  2: `
    font-size: 16px;
    line-height: 24px;
  `,
  3: `
    font-size: 12px;
    line-height: 18px;
  `,
};

export const Text = styled(T)`
  ${({ level = 2 }) => textMap[level]};
  color: ${({ error, dark, light }) =>
    error ? colors.red : dark ? colors.black : light ? colors.gray : colors.darkGray};
  font-weight: ${({ medium }) => (medium ? 500 : 400)};
`;

export const Label = styled(T)`
  color: ${colors.darkGray};
  font-size: 16px;
  font-weight: 500;
`;

export const AccentText = styled(T)`
  color: ${({ primary }) => (primary ? colors.purple : colors.gray)};
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.6px;
  text-transform: uppercase;
`;

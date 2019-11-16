import styled from 'styled-components';
import { View } from 'react-native';

const spacingUnit = 8;

const s = v => v * spacingUnit;

export default styled(View)`
  margin: ${({ ma, mv, mh, ml, mr, mt, mb }) =>
    `${s(mt || mv || ma || 0)}px 
    ${s(mr || mh || ma || 0)}px 
    ${s(mb || mv || ma || 0)}px 
    ${s(ml || mh || ma || 0)}px`};
  padding: ${({ pa, pv, ph, pl, pr, pt, pb }) =>
    `${s(pt || pv || pa || 0)}px 
    ${s(pr || ph || pa || 0)}px 
    ${s(pb || pv || pa || 0)}px 
    ${s(pl || ph || pa || 0)}px`};
`;

/*
 * code for redirecting secondary cores to their start address
 *
 * Copyright (c) 2013	Andre Przywara <andre.przywara@linaro.org>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <config.h>
#include <linux/linkage.h>

/* void _smp_waitloop(unsigned previous_address); */
ENTRY(smp_waitloop)
	wfi
	ldr	r1, =CONFIG_SYSFLAGS_ADDR	@ load start address
	ldr	r1, [r1]
	cmp	r0, r1			@ make sure we dont execute this code
	beq	smp_waitloop		@ again (due to a spurious wakeup)
	mov	pc, r1
ENDPROC(smp_waitloop)
